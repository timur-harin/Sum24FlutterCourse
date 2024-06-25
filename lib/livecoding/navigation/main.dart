import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
<<<<<<< HEAD
  runApp(const MyApp());
=======
  runApp(MyApp());
>>>>>>> main
}

final Map<String, String> routes = {
  '/': '/one',
  '/second': '/second',
  '/third': '/third',
  '/generated': '/generated',
};

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  const MyApp({super.key});

=======
>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Example',
        // initialRoute: '/one',
        routes: {
<<<<<<< HEAD
          '/one': (context) => const HomeScreen(),
          '/second': (context) => const SecondScreen(),
          '/third': (context) => const ThirdScreen(),
=======
          '/one': (context) => HomeScreen(),
          '/second': (context) => SecondScreen(),
          '/third': (context) => ThirdScreen(),
>>>>>>> main
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
<<<<<<< HEAD
          return null;
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const UndefindPage());
=======
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UndefindPage());
>>>>>>> main
        });
  }
}

class HomeScreen extends StatelessWidget {
<<<<<<< HEAD
  const HomeScreen({super.key});

=======
>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Home Screen'),
=======
        title: Text('Home Screen'),
>>>>>>> main
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
<<<<<<< HEAD
              child: const Text('Go to Second Screen'),
=======
              child: Text('Go to Second Screen'),
>>>>>>> main
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/third',
                  arguments: 'Hello from Home Screen one more!',
                );
              },
<<<<<<< HEAD
              child: const Text('Go to Third Screen'),
=======
              child: Text('Go to Third Screen'),
>>>>>>> main
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
<<<<<<< HEAD
  const SecondScreen({super.key});

=======
>>>>>>> main
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Second Screen'),
=======
        title: Text('Second Screen'),
>>>>>>> main
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
<<<<<<< HEAD
              child: const Text('Go Back'),
=======
              child: Text('Go Back'),
>>>>>>> main
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
<<<<<<< HEAD
        title: const Text('Third Screen'),
=======
        title: Text('Third Screen'),
>>>>>>> main
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
<<<<<<< HEAD
              child: const Text('Go Back'),
=======
              child: Text('Go Back'),
>>>>>>> main
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
<<<<<<< HEAD
        title: const Text('Undefind Page'),
      ),
      body: const Center(
=======
        title: Text('Undefind Page'),
      ),
      body: Center(
>>>>>>> main
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
