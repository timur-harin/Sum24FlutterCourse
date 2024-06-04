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
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 14,
          fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(Icons.home,
        size: 150, color: Color.fromARGB(0, 255, 0, 0));
  }

  Widget exercise3() {
    return Image.network(
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.cnn.com%2F2020%2F01%2F27%2Fsport%2Fkobe-bryant-legacy-spt-intl%2Findex.html&psig=AOvVaw2J_3-MdF5ZIIoQ0s_aBjLr&ust=1717608610541000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLCXhOu8woYDFQAAAAAdAAAAABAE",
        width: 130,
        height: 130,
        fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () => (print("Pressed")), child: const Text("press me"));
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Color.fromARGB(150, 0, 50, 87),
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
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.cnn.com%2F2020%2F01%2F27%2Fsport%2Fkobe-bryant-legacy-spt-intl%2Findex.html&psig=AOvVaw2J_3-MdF5ZIIoQ0s_aBjLr&ust=1717608610541000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLCXhOu8woYDFQAAAAAdAAAAABAE",
              width: 130,
              height: 130),
        ),
      ],
    );
  }
}