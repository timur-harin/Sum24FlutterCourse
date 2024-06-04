import 'package:flutter/material.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAb1HomePage(),
    );
  }
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.stars),
        title: const Text('Lab 2'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: myWidget(),
    );
  }

  Widget myWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          exercise1(),
          const SizedBox(
            height: 25,
          ),
          exercise2(),
          const SizedBox(
            height: 25,
          ),
          exercise3(),
          const SizedBox(
            height: 25,
          ),
          exercise4(),
          const SizedBox(
            height: 25,
          ),
          exercise5(),
        ],
      ),
    );
  }

  Widget exercise1() {
  return const Text(
      'Hello Flutter!',
      style: TextStyle(
      fontSize: 24.0,
      color: Colors.green, 
      fontWeight: FontWeight.bold,
    ),
  );
}

  Widget exercise2() {
    return const Icon(
      Icons.stars,
      size: 125,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2MhDs25KKZOGqzzQh_UoPEoITxhTmj9NXPA&s'
      );
  }

  Widget exercise4() {
  return TextButton(
    onPressed: () {
      print('Pressed');
    },
    child: Text('Press me'),
  );
}
  Widget exercise5() {
  return Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(),
        ),
        child: const Text(
          'Hello Flutter!',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(),
        ),
        child: const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    ],
  );
}
}