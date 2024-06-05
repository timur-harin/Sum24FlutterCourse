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
    return const Text("Hello Flutter!"); // Text
    style:
    TextStyle(
        fontSize: 90,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 10, 175, 197));
  }

  Widget exercise2() {
    return const Icon(
      Icons.abc,
      size: 100,
      color: Color.fromARGB(255, 203, 1, 92),
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage(
          'https://media.istockphoto.com/id/1040906722/ru/%D1%84%D0%BE%D1%82%D0%BE/%D0%B6%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D0%B0-%D0%B8-%D0%BC%D1%83%D0%B6%D1%87%D0%B8%D0%BD%D0%B0-%D0%B3%D0%BB%D1%8F%D0%B4%D1%8F-%D0%BD%D0%B0-%D0%B6%D0%B8%D0%B2%D0%BE%D0%BF%D0%B8%D1%81%D0%BD%D1%8B%D0%B9-%D0%B2%D0%B8%D0%B4-%D0%BD%D0%B0-%D0%B4%D0%B5%D1%80%D0%B5%D0%B2%D0%BD%D1%8E-%D0%B3%D0%BE%D1%80%D0%B4%D0%B5%D1%81-%D0%B2-%D0%BF%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D1%81%D0%B5.jpg?s=612x612&w=0&k=20&c=KMTvXuNZVukLwfaeXqXXHZTskxZqmoeof0p2jUvRNUM='),
      width: 40,
      height: 100,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      },
      child: const Text('idk'),
    );
  }

  Widget exercise5() {
    return Column(children: [
      Container(
          // child: Text('textOne'),
          width: 100,
          height: 50,
          margin: const EdgeInsets.all(3.0),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 17, 255, 1))),
      Container(
        child: Icon(Icons.home),
      )
    ]);
  }
}
