// Use these dependencies for your classes
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'comment.dart';
import 'post.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) 
      {
        if (settings.name == '/generated') {
          final int code = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => GeneratedPage(code: code),
          );
        }else{
          return MaterialPageRoute(builder: (context) => UndefindPage(settings.name!));
        }
      },

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final post = (await fetchPosts()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First Post',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'User Id: ${post.userId}\n'
                            'Id: ${post.id}\n'
                            'Title: ${post.title}\n'
                            'Body: ${post.body}\n',
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                );
              },
              child: const Text('Json Task'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final comment = (await fetchComments()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First Comment',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'Post Id: ${comment.postId}\n'
                            'Id: ${comment.id}\n'
                            'Name: ${comment.name}\n'
                            'Email: ${comment.email}\n'
                            'Body: ${comment.body}\n',
                          ),
                        )
                      ]),
                );
              },
              child: const Text('Json Serialiable Task'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                final user = (await fetchUsers()).first;
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                      title: const Text(
                        'The First User',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            'Id: ${user.id}\n'
                            'Name: ${user.name}\n'
                            'Username: ${user.username}\n'
                            'Email: ${user.email}\n'
                            'Address: ${user.address['street']}\n'
                            'Phone: ${user.phone}\n'
                            'Company: ${user.company['name']}\n',
                            textAlign: TextAlign.left,
                          ),
                        )
                      ]),
                );
              },
              child: const Text('freezed Task'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4,
                  right: MediaQuery.of(context).size.width * 0.4,
                  top: 10.0,
                  bottom: 10.0),
              child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter status code',
                    border: OutlineInputBorder(),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                final statusCode = int.tryParse(controller.text);
                if (statusCode != null) {
                  Navigator.of(context)
                      .pushNamed('/generated', arguments: statusCode);
                }
              },
              child: const Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}


class UndefindPage extends StatelessWidget {
  final String name;

  const UndefindPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}

    class GeneratedPage extends StatelessWidget {
      final int code;

      const GeneratedPage({Key? key, required this.code}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Scaffold(appBar: AppBar(),
      body: Center(
        child: Image.network('https://http.cat/$code'),
      ),
    );
  }
}


// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]



//

