// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text('Hello World!'),
//         ),
//       ),
//     );
//   }
// }


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
      "Hello Flutter!",
      style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 25,
          fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(Icons.home,
        size: 200, color: Color.fromARGB(255, 0, 0, 0));
  }

  Widget exercise3() {
    return Image.network(
        "https://static.xabar.uz/crop/2/4/720_460_95_2479473632.jpg",
        width: 100,
        height: 100,
        fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () => (print("Pressed")), child: const Text("press it"));
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 25, vertical: 25),
          margin: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
              color: Color.fromARGB(0, 32, 72, 87),
              border: Border.all(color: Color.fromARGB(255, 0, 0, 0))),
          child: const Text(
            "Column",
          ),
        ),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 25, vertical: 25),
          margin: const EdgeInsets.symmetric(vertical: 50),
          decoration: const BoxDecoration(color: Color.fromARGB(0, 32, 72, 87)),
          child: Image.network(
              "https://static.xabar.uz/crop/2/4/720_460_95_2479473632.jpg",
              width: 100,
              height: 100),
        ),
      ],
    );
  }
}