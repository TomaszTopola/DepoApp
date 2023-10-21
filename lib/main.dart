import 'package:depo_app/common/dark_theme.dart';
import 'package:depo_app/common/light_theme.dart';
import 'package:depo_app/views/check_status.dart';
import 'package:depo_app/views/landing_page.dart';
import 'package:depo_app/views/login_page.dart';
import 'package:flutter/material.dart';

import 'common/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
      title: 'DepoApp',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      initialRoute: '/landing',
      routes:{
        '/landing': (context) => const LandingPage(),
        '/depo/status': (context) => const CheckStatus(),
        '/login': (context) => const LoginPage(),
      }
  ));
}