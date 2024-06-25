import 'package:education/livecoding/pixel_perfect/ui/theme.dart';
import 'package:flutter/material.dart';

import 'pages/details_page.dart';
import 'pages/list_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Perfect Demo',
      theme: theme,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/list': (context) => const ListPage(),
        '/details': (context) => const DetailsPage(),
      },
      initialRoute: '/',
    );
  }
}
