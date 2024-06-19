import 'package:flutter/material.dart';
import 'dart:convert';
import 'cat_status_code.dart';
import 'status_page.dart';
import 'package:http/http.dart' as http;
import 'fetch_cat_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Status Codes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/status') {
          final args = settings.arguments as CatStatusCode;
          return MaterialPageRoute(
            builder: (context) {
              return StatusPage(catStatusCode: args);
            },
          );
        }
        return MaterialPageRoute(builder: (context) => UndefinedPage());
      },
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Codes'),
      ),
      body: FutureBuilder<List<CatStatusCode>>(
        future: fetchCatStatusCodes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final statuses = snapshot.data!;
            return ListView.builder(
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                final status = statuses[index];
                return ListTile(
                  title: Text('Status Code: ${status.statusCode}'),
                  subtitle: Text(status.message),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/status',
                      arguments: status,
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final CatStatusCode catStatusCode;

  StatusPage({required this.catStatusCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Code: ${catStatusCode.statusCode}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Status Code: ${catStatusCode.statusCode}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Image.network('https://http.cat/${catStatusCode.statusCode}'),
          ],
        ),
      ),
    );
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
        child: Image.network('https://http.cat/404'),
      ),
    );
  }
}



