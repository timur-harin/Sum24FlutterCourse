// Use these dependencies for your classes
import 'dart:convert';
import 'package:education/templates/lab5/comment.dart';
import 'package:education/templates/lab5/post.dart';
import 'package:education/templates/lab5/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
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
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Cats',
      //Color.fromARGB(255, 255, 154, 233),
      home: HomeScreen(),
  onGenerateRoute: (settings) {
    Uri uri = Uri.parse(settings.name ?? '');
    if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'generated') {
      var statusCode = int.tryParse(uri.pathSegments[1]);
      return MaterialPageRoute(
        builder: (context) => CatStatusCodePage(statusCode: statusCode),
        settings: settings,
      );
    }

  },

);
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 186, 231),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 216, 119, 192),
        title: const Text('Enter a Status Code', style: TextStyle(color: Color.fromARGB(255, 80, 12, 101))),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
            width: 200,
            height: 70,
            margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment(0.8, 0.5),
              colors: <Color>[
                Color.fromARGB(255, 196, 166, 255),
                Color.fromARGB(255, 246, 125, 252),
                Color.fromARGB(255, 251, 78, 202),
              ], 
              tileMode: TileMode.mirror,
                        ),
                borderRadius: BorderRadius.circular(52),
              ),
              child: InkWell(
                
                onTap: () async{
                final response = await fetchPosts();
                showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Ex 1'), content: Text(response.first.title! + '\n' + response.first.body!)));
                }, 
                child: const Align(child: Text('Ex 1', style: TextStyle(color: Color.fromARGB(255, 80, 12, 101)),), alignment: Alignment.center,),),
            ),
          
            Container(
              margin: const EdgeInsets.all(16.0),
            width: 200,
            height: 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 196, 166, 255),
                Color.fromARGB(255, 152, 186, 249),
                Color.fromARGB(255, 241, 143, 213),
              ], 
              tileMode: TileMode.mirror,
                        ),
                borderRadius: BorderRadius.circular(52),
              ),
              child: InkWell(onTap: () async{
              final response = await fetchComments();
              showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Ex 2'), content: Text(response.first.id!.toString() + '\n' + response.first.body! + '\n' + response.first.email! + '\n' + response.first.name!)));},child: const Align(child: Text('Ex 2', style: TextStyle(color: Color.fromARGB(255, 80, 12, 101)),), alignment: Alignment.center,),),         
              ),
               Container(
            width: 200,
            height: 70,
            margin: const EdgeInsets.only(top: 16.0, bottom: 32.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment(0.8, 0.5),
              colors: <Color>[
                Color.fromARGB(255, 196, 166, 255),
                Color.fromARGB(255, 246, 125, 252),
                Color.fromARGB(255, 251, 78, 202),
              ], 
              tileMode: TileMode.mirror,
                        ),
                borderRadius: BorderRadius.circular(52),
              ),
              child: InkWell(
                
                onTap: () async{
              final response = await fetchUsers();
              showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Ex 3'), content: Text(response.first.id!.toString() + '\n' + response.first.username! + '\n' + response.first.email! + '\n' + response.first.name!)));}, child: const Align(child: Text('Ex 3', style: TextStyle(color: Color.fromARGB(255, 80, 12, 101)),), alignment: Alignment.center,),),
               ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Status Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  child: const Text('Show Cat', style: TextStyle(color: Color.fromARGB(255, 80, 12, 101)),),
  onPressed: () {
    int? statusCode = int.tryParse(_controller.text);
    if (statusCode != null) {
      Navigator.of(context).pushNamed('/generated/$statusCode');
    }
  },
),
          ],
        ),
      ),
    );
  }
}

class CatStatusCodePage extends StatelessWidget {
  final int? statusCode;

  const CatStatusCodePage({Key? key, this.statusCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code: $statusCode'),
      ),
      body: Center(
        child: Image.network('https://http.cat/$statusCode'),
      ),
    );
  }
}
