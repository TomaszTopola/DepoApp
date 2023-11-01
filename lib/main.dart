import 'package:depo_app/common/dark_theme.dart';
import 'package:depo_app/common/light_theme.dart';
import 'package:depo_app/views/edit_depo.dart';
import 'package:depo_app/views/landing_page.dart';
import 'package:depo_app/views/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
      title: 'DepoApp',
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      initialRoute: '/landing',
      routes:{
        '/landing': (context) => const LandingPage(),
        '/depo/edit': (context) => EditDepo(),
        '/login': (context) => const LoginPage(),
      }
  ));
}