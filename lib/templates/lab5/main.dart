import 'package:flutter/material.dart';

void main() {
  runApp(Lab5());
}

class Lab5 extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lab5 solution",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/initial',
    );
  }
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab5 solution"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/status', arguments: 102); 
              },
              child: const Text('102 status'), 
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/status', arguments: 205); 
              },
              child: const Text('205 status'), 
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/status', arguments: 400); 
              },
              child: const Text('400 status'), 
            ),
        ],
      )
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  final int status;

  StatusPage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab5 solution. Status $status"),
      ),
      body: Center (
        child: Image.network('https://http.cat/$status',
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Column(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
                const SizedBox(height: 20),

                Text('Status $status not found or can\'t load'),
              ],
            );
          },
        )
      )
    );
  }
}

class RouteGenerator {
  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) =>
     Scaffold(
      appBar: AppBar(title: const Text('ERROR!!!')),

      body: Center(
        child: Image.network('https://https.cat/404',
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Column(
              children: [
                Icon (
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox(height: 20),
                Text('Status 404 not found or can\'t load'),
              ],
            );
          }
        )
      ),
    ),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/initial':
        return MaterialPageRoute(builder: (_) => InitialPage());
      case '/status':
        if (settings.arguments is int) {
          final status = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => StatusPage(status: status));
        }
        return errorRoute();
      default:
        return errorRoute();
    }
  }
}



// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

