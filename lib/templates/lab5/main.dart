// Use these dependencies for your classes
import 'package:education/livecoding/navigation/main.dart';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:flutter/material.dart';


void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/posts': (context) => SecondScreen(),
        '/comments': (context) => ThirdScreen(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name.contains('/generated')) {
          return MaterialPageRoute(
            builder: (context) => CatPage(statusCode: settings.name!),
          );
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => UndefindPage(),
        );
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class CatPage extends StatelessWidget {
  final String statusCode;

  CatPage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Page'),
      ),
      body: Center(
        child: Image.network("https://http.cat/$statusCode"),
      ),
    );
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
            Text(""),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/posts');
              },
              child: Text('Go to Posts'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
              child: Text('Go to Comments'),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/generated');
              },
              child: Text('Go to Cats'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen with posts'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen with comments'),
      ),
      body: FutureBuilder(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data![index].body),
                    subtitle: Text(snapshot.data![index].name),
                  ),
                );
              },
            );
          } else {
            return Text('${snapshot.error}');
          }
        },
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Page'),
      ),
      body: Center(
        child: Text('Undefined Page'),
      ),
    );
  }
}
// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

