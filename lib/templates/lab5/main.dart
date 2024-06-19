// Use these dependencies for your classes
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/comment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Lab 5',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/second': (context) => const SecondPage(),
        '/posts': (context) => Posts(),
        '/comments': (context) => Comments(),


        //'/workout': (context) => const WorkoutPage(),
        //'/finish': (context) => const FinishPage(),
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (context) => UndefinedPage());
      },
      onGenerateRoute: (settings) {
        if (routes.containsKey(settings.name)) {
          return MaterialPageRoute(
              builder: (context) =>
                  MainPage());
        }
        final name = settings.name ?? '';

        if (name.contains('/generated')) {

          return MaterialPageRoute(
              builder: (context) =>
                  GeneratedPage(statusCode: settings.name!));
        }
      },
    );
  }
}
// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]
class GeneratedPage extends StatelessWidget{
  String statusCode;
  GeneratedPage({super.key, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network("https://http.cat/$statusCode"),
      ),
    );
  }

}

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Hello"),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/second');
            }, child: Text("Second")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/posts');
            }, child: Text("Posts")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/comments');
            }, child: Text("Comments")),

    ],),),);
  }
}
/*void getJson() async{
  final url = Uri.parse("http://jsonplaceholder.typicode.com/posts");

  final response = await http.get(url);

  if(response.statusCode == 200){
    Post.fromJson(jsonDecode(response.body));
  }else{
    print("Request failed with status ${response.statusCode}");
  }
}*/
class SecondPage extends StatelessWidget{
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("This is second page"),
          ],
        ),
      ),
    );
  }

}
class Posts extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: FutureBuilder<List<Post>>(
          future: fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].body),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading posts'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
  }
}
class Comments extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: FutureBuilder<List<Comment>>(
          future: fetchComments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading comments'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].body),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No comments found'));
            }
          },
        ),
      );

  }
}


class UndefinedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("The page is undefined", style: TextStyle(fontSize: 40),),

          ],
        ),
      ),
    );
  }

}

