import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/core/errors/app_exception.dart';
import 'package:dummy/presentation/auth/bloc/auth_bloc.dart';
import 'package:dummy/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

void main() {
  late _MockAuthBloc authBloc;

  setUpAll(() => registerFallbackValue(const AuthLogoutRequested()));

  setUp(() {
    authBloc = _MockAuthBloc();
    when(() => authBloc.state).thenReturn(const AuthUnauthenticated());
  });

  Future<void> pumpLogin(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: const LoginPage(),
      ),
    ),
  );

  testWidgets('validates empty fields without submitting', (tester) async {
    await pumpLogin(tester);

    await tester.tap(find.text('Sign in'));
    await tester.pump();

    expect(find.text('Enter your username'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    verifyNever(() => authBloc.add(any()));
  });

  testWidgets('submits the entered credentials', (tester) async {
    await pumpLogin(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'emilys',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'emilyspass',
    );
    await tester.tap(find.text('Sign in'));

    verify(
      () => authBloc.add(
        const AuthLoginSubmitted(username: 'emilys', password: 'emilyspass'),
      ),
    ).called(1);
  });

  testWidgets('demo account button fills the form', (tester) async {
    await pumpLogin(tester);

    await tester.tap(find.text('Use demo account'));
    await tester.pump();
    await tester.tap(find.text('Sign in'));

    verify(
      () => authBloc.add(
        const AuthLoginSubmitted(username: 'emilys', password: 'emilyspass'),
      ),
    ).called(1);
  });

  testWidgets('shows the login error', (tester) async {
    when(() => authBloc.state).thenReturn(
      const AuthUnauthenticated(
        error: ApiException('Invalid credentials', statusCode: 400),
      ),
    );
    await pumpLogin(tester);

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('shows a session expired notice', (tester) async {
    when(
      () => authBloc.state,
    ).thenReturn(const AuthUnauthenticated(sessionExpired: true));
    await pumpLogin(tester);

    expect(find.textContaining('session has expired'), findsOneWidget);
  });

  testWidgets('disables the form while signing in', (tester) async {
    when(() => authBloc.state).thenReturn(const AuthLoginInProgress());
    await pumpLogin(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });
}
