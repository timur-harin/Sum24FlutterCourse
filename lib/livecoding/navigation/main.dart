import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}

final Map<String, String> routes = {
  '/': '/one',
  '/second': '/second',
  '/third': '/third',
  '/generated': '/generated',
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Example',
        // initialRoute: '/one',
        routes: {
          '/one': (context) => HomeScreen(),
          '/second': (context) => SecondScreen(),
          '/third': (context) => ThirdScreen(),
        },
        // onGenerateInitialRoutes: (
        onGenerateRoute: (settings) {
          if (routes.containsKey(settings.name)) {
            return MaterialPageRoute(
                builder: (context) => GeneratedPage(title: settings.name!));
          }
          final name = settings.name ?? '';
          print(name);
          if (name.contains('/generated')) {
            print(true);
            return MaterialPageRoute(
                builder: (context) => GeneratedPage(title: name));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UndefindPage());
        });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/second',
                  arguments: 'Hello from Home Screen!',
                );
              },
              child: Text('Go to Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/third',
                  arguments: 'Hello from Home Screen one more!',
                );
              },
              child: Text('Go to Third Screen'),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(message ?? 'Hello from Second Screen!'),
            ElevatedButton(
              onPressed: () {
                // Go back to the previous screen.
                Navigator.of(context).pop();
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(message),
            ElevatedButton(
              onPressed: () {
                // Go back to the previous screen.
                Navigator.of(context).pop();
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class UndefindPage extends StatelessWidget {
  const UndefindPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefind Page'),
      ),
      body: Center(
        child: Text('Undefind Page'),
      ),
    );
  }
}

class GeneratedPage extends StatefulWidget {
  const GeneratedPage({super.key, required this.title});
  final String title;

  @override
  State<GeneratedPage> createState() => _GeneratedPageState();
}

class _GeneratedPageState extends State<GeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
