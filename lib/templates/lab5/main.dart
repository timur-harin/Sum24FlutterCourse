// Use these dependencies for your classes
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

void main() {
  runApp(Lab5App());
}

// TODO add needed classes for Flutter APP
class Lab5App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class CatScreen extends StatelessWidget {
  final int statusCode;
  CatScreen({required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$statusCode is a cat!"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Image.network('https://http.cat/$statusCode'),
              Text("$statusCode: Meow meow")
            ],
          ),
        ));
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/cat':
        return MaterialPageRoute(
            builder: (context) =>
                CatScreen(statusCode: (args as CatPageArguments).statusCode));
      default:
        return _errorRoute(); // "undefined" route
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Route is undefined"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Image.network('https://http.cat/404'),
                Text("Page not found :(")
              ],
            ),
          ));
    });
  }
}

class CatPageArguments {
  final int statusCode;

  CatPageArguments(this.statusCode);
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Input your lucky status code:"),
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                  ),
                )),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cat',
                      arguments: CatPageArguments(int.parse(controller.text)));
                },
                label: Text("Give me a cat!"),
                icon: Icon(Icons.pets))
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

