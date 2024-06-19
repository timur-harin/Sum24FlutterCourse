// Use these dependencies for your classes
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

TextEditingController textController = TextEditingController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, String> routes = {
    '/': '/one',
    '/generated': '/generated',
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          if (routes.containsKey(settings.name)) {
            return MaterialPageRoute(builder: (context) => MainScreen());
          }
          final name = settings.name ?? '';
          if (name.contains('/generated')) {
            return MaterialPageRoute(builder: (context) => CatStatusCodePage(statusCode: settings.name!));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const UndefinedPage());
        });
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network("https://http.cat/404"),
            const Text("Undefined Page"),
          ],
        ),
      ),
    );
  }
}

class CatStatusCodePage extends StatefulWidget{
  const CatStatusCodePage({super.key, required this.statusCode});
  final String statusCode;
  
  @override
  State<StatefulWidget> createState() => _CatStatusCodeState();
}

class _CatStatusCodeState extends State<CatStatusCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Image.network("https://avatars.mds.yandex.net/i?id=2a00000179f3bd83e0a51655ce9534c8d5fc-4599768-images-thumbs&n=13"),
          Text("Find cats! : ${widget.statusCode}"),
        ],),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text',
              ),
              controller: textController,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/${textController.text}', arguments: textController.text);
              },
              child: const Text("Open the cats!"),
            ),
          ],
        ),
      ),
    );
  }
}