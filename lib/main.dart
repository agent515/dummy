import 'package:flutter/material.dart';

import 'app/app.dart';
import 'injectable/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
