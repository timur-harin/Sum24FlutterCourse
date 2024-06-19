import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => const Center(
          child: Center(
            child: Text("Put cat number in the address"),
          ),
        ),
      },
      onGenerateRoute: (argument) {
        return MaterialPageRoute(
            builder: (context) => CatPage(catNumber: argument.name?? "/404"));
      },
    );
  }
}

class CatPage extends StatelessWidget {
  const CatPage({super.key, required this.catNumber});
  final String catNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://http.cat/$catNumber'),
      ),
    );
  }
}

