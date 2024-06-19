// Use these dependencies for your classes
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
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
    '/': '/',
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
            return MaterialPageRoute(
                builder: (context) =>
                    MainScreen());
          }
          final name = settings.name ?? '';
          
          if (name.contains('/generated')) {
           
            return MaterialPageRoute(
                builder: (context) =>
                    CatStatusCodePage(statusCode: settings.name!));
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const UndefinedPage());
        });
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String postst = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(postst),
            ElevatedButton(onPressed: ()async  {
              final posts = await fetchPosts();
            
              print(posts.first);
              postst = Post.toJson(posts.first).toString();
            
              setState(() { });
            },
            child: Text("Task1"),
            ),
            ElevatedButton(onPressed: () async {
              final comments = await fetchComments();

              print(comments.first);
              postst =Comment.toJson(comments.first).toString();
              setState(() { });
            }, 
            child: Text("Task2")
            ),
            ElevatedButton(onPressed: () async {
              final users = await fetchUsers();
              print(users.first);
              postst = users.first.toString();
              setState(() { });
            }, 
            child: Text("Task3")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/generated/${textController.text}',
                    arguments: textController.text);
              },
              child: const Text("Открыть котов"),
            )
          ],
        ),
        ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Undefined page'),
      ),
    );
  }
}

class CatStatusCodePage extends StatelessWidget {
  final String statusCode;
  const CatStatusCodePage({Key? key, required this.statusCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final uri = 'https://http.cat/${statusCode.split('/').last}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Status code: $statusCode'),
      ),
      body: Center(
        child: Image.network(uri),
      ),
    );
  }
}