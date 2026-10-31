# DummyJSON Shop

A small Flutter app built against the public [DummyJSON](https://dummyjson.com) API: sign in, browse a paginated product catalogue, and open product details. The session is stored securely and restored on launch, and access tokens are refreshed automatically.

Test account: `emilys` / `emilyspass` (the login screen has a **Use demo account** shortcut).

## Setup

Requires **Flutter 3.44.0 / Dart 3.12** (pinned in `.fvmrc`; `pubspec.yaml` needs Dart `^3.12.0`).

```bash
flutter pub get
flutter run
```

Generated code (`*.g.dart`, `*.freezed.dart`, `*.gr.dart`, `*.config.dart`) is committed, so the app runs without a codegen step. After changing annotated code, regenerate it:

```bash
dart run build_runner build
```

### Tests

```bash
flutter test                                  # unit + widget tests (offline)
```

The end-to-end flows run against the live API on a simulator or device. Run them in this order: the second one relies on the session the first one leaves behind.

```bash
flutter drive --driver=test_driver/integration_test.dart \
  --target=integration_test/login_flow_test.dart       # login → paginate → details
flutter drive --driver=test_driver/integration_test.dart \
  --target=integration_test/session_restore_test.dart  # relaunch skips login → sign out
```

Screenshots are written to `build/screenshots/`.

## Architecture

Clean-architecture layers. Dependencies point inward: presentation → domain ← data.

```text
lib/
├── app/            App widget (router + auth listener) and theme
├── const/          API base URL, timeouts, endpoints, page size
├── core/
│   ├── errors/     AppException hierarchy (the only error type above the data layer)
│   ├── network/    Dio factory, AuthInterceptor, DioException → AppException mapping,
│   │               SessionExpiryNotifier
│   ├── storage/    TokenStorage (flutter_secure_storage)
│   └── utils/      Formatters
├── domain/         Pure Dart: Freezed entities, repository + data source contracts, use cases
├── data/           Retrofit APIs + data source impls, Freezed/JSON DTOs with toEntity(),
│                   repository impls
├── injectable/     GetIt + Injectable setup; modules for Dio, Retrofit and secure storage
├── presentation/   Pages, widgets and BLoCs (auth, products, product details)
└── utils/          AppRouter (AutoRoute + guards), user-facing error messages, sizes
```

**How a request flows:** Bloc → use case → repository (contract in `domain`, implementation in `data`) → remote data source → Retrofit → Dio + `AuthInterceptor`.

The remote data source is the boundary between transport and domain:
- It maps DTOs to entities.
- It turns every `DioException` or parsing error into an `AppException`, via `ApiErrorHandler.guard`.

Blocs therefore only ever catch `AppException`.

**Why data sources *and* repositories:** the domain defines the data source contracts, and they return entities, not DTOs. That keeps `domain` free of data-layer types. Repositories then combine sources. For example, `AuthRepositoryImpl` uses the remote source plus `TokenStorage`. `ProductRepositoryImpl` is a thin pass-through today; a local cache would plug in there.

## Authentication & networking

- **Token storage.** `TokenStorage` keeps the access/refresh pair in the keychain or keystore. On iOS it uses `first_unlock_this_device`, so tokens aren't included in backups or restored onto another device. The access token is also cached in memory, because it's read on every request.
- **AuthInterceptor** (a Dio `QueuedInterceptor`):
  - It attaches `Authorization: Bearer …` to every request except those marked `skipAuth` (login).
  - On a **401** it calls `POST /auth/refresh`, saves the new pair and retries the request once.
  - A **4xx from refresh** means the refresh token was rejected. It clears storage and emits on `SessionExpiryNotifier`, which `AuthBloc` turns into a redirect to login with a "session expired" notice.
  - **Network errors or 5xx from refresh** keep the session (it's a temporary problem) and surface the error.
- **No recursion or deadlock.** Refresh *and* the retry go through a second, interceptor-free `Dio` (`plainDio`). The refresh call can't trigger another refresh. A retry that fails again can't queue behind the error handler that is waiting for it, which would be a deadlock with `QueuedInterceptor`.
- **Concurrent 401s.** `QueuedInterceptor` handles errors one at a time. If an error was raised with an access token that has *already* been replaced, it's simply retried with the new token. That's the standard `QueuedInterceptor` approach, and three parallel 401s produce one refresh (covered by a test).
- **Swappable.** The interceptor is wired up in one place, `NetworkModule.dio`, and nothing else references it except the `skipAuthKey` constant. A different implementation (e.g. a dedicated `AuthErrorInterceptor`) can replace it there.
- **Session restore.** On startup, `AuthBloc` asks the repository to restore the session:
  - With stored tokens, it calls `GET /auth/me`. That checks the token, refreshes it if it has expired, and returns the user's profile for the app bar.
  - If verification fails for a non-auth reason, e.g. starting offline, the user stays signed in instead of being logged out.

### DummyJSON behaviours worth knowing

These were checked against the live API while building:

| Case | Response |
|------|----------|
| Wrong password | `400 {"message":"Invalid credentials"}`, shown as-is |
| Expired access token | `401 "Token Expired!"`, which triggers refresh |
| Malformed access token | `500 "invalid token"`, not 401 (never happens with real tokens) |
| Invalid refresh token | `403`, so the session ends |
| `GET /products` with an expired token | `200`: the catalogue is public |

Because the catalogue is public, `/auth/me` at startup is in practice the call that exercises the refresh path. The refresh round trip was verified against the live server with a token issued for 1 minute.

## Products & pagination

`ProductsBloc` tracks `products`, `total`, `isLoadingMore`, `isRefreshing`, `error` and `loadMoreError`.

- **Triggering the next page.** It fires when the remaining scroll extent drops below 600 px. Scroll *metrics* notifications are watched as well as scroll updates, so a first page too short to scroll (large screens) still loads more.
- **No duplicate requests:**
  - The `droppable()` transformer ignores "next page" events while one is in flight.
  - Paging is also refused while refreshing, at the end of the list, or after a failed page until the user taps **Retry**. Without that last rule, the error footer's layout change would retrigger the request in a loop.
- **Refresh vs. an in-flight page.** A generation counter discards a page response that arrives after a pull-to-refresh has reset the list.
- **Errors keep data.** A failed next page shows an inline retry under the existing items. A failed refresh keeps the list and shows a snackbar. Only an initial-load failure replaces the screen.
- **End of list.** `skip` is the number of products already loaded, and the end is reached when that count hits `total`. An empty page also ends pagination, in case `total` is wrong.

## Navigation

- **Routes:** AutoRoute with generated routes. `/` is a splash shown during session restore, then `/login`, `/products` and `/products/:id`. The details page receives only the id and loads the product itself.
- **Redirects:** one `BlocListener<AuthBloc>` at the app root calls `replaceAll` to Products when the user becomes signed in, and to Login when they become signed out. That one rule covers startup restore, login, logout and a refresh failure mid-session.
- **Guards** (an auth guard on product routes, a guest guard on login) are a backstop for navigation that bypasses the listener.

## Testing

70 unit/widget tests, plus 2 integration flows:

| Area | What's covered |
|------|----------------|
| `core/` | Interceptor: token attach, refresh + retry, single refresh for concurrent 401s, rejected vs. transient refresh failure, no refresh for `skipAuth`. Error mapping; token storage persistence |
| `data/` | DTO parsing from real API payloads (including missing fields), entity mapping, `AuthRepositoryImpl` token handling and session restore |
| `domain/` | Use case delegation and input normalisation |
| `presentation/` | `AuthBloc` (restore outcomes, login, de-duplicated submits, logout, external expiry); `ProductsBloc` (append, de-dupe, end of list, error retention, retry gating, refresh, stale-page discard); `ProductDetailsBloc`; widget tests for the login form and each products-page state |

## Decisions & trade-offs

- **`freezed: ^3.2.6-dev.1`, a prerelease.** freezed 4 needs Dart ≥ 3.13. The stable 3.x releases require analyzer ≤ 10, which conflicts with the formatter Dart 3.12 needs. The dev build is the 3.x line rebuilt for analyzer 12. Move to freezed 4 when upgrading Flutter.
- **Extra packages:**
  - `bloc_concurrency`: official bloc transformers, so de-duplication isn't hand-rolled.
  - `cached_network_image`: image caching and placeholders.
  - `integration_test`: the end-to-end flows.
  - No `intl`: one price format and one date format didn't justify it.
- **Equatable for bloc states/events, Freezed for entities and DTOs**, as specified.
  - `AuthEntity` and `LoginRequestDto` skip the generated `toString`, so tokens and passwords never reach logs.
  - The debug `LogInterceptor` logs request lines and status codes only, never headers or bodies.
- **Minor additions to the suggested structure:**
  - `ProductDetailsBloc`, for the details page's own load/error/retry.
  - `RestoreSessionUseCase` and `LogoutUseCase`, so `AuthBloc` goes through use cases consistently.
  - `user_dto.dart` for `/auth/me`.
  - `session_expiry_notifier.dart` and `core/utils/formatters.dart`.
  - `app/app_theme.dart`.
- **`AuthBloc` is an app-wide lazy singleton**, because the router guards read its state. Feature blocs are factories scoped to their pages.

## Known limitations

- **iOS keychain survives uninstall**, so a reinstall restores the previous session. The usual fix is a first-run flag in `shared_preferences` that clears the keychain; it's left out to keep dependencies minimal.
- **No offline cache for products.** `ProductRepository` is where one would be added.
- **No logout API call.** DummyJSON has no logout endpoint, so logout only clears local tokens.
