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
        title: const Text('Lab 1'),
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
    // return const FlutterLogo(
    //   size: 100,
    // );

    return const Text("Hello Flutter!", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red, fontSize: 10));
  }

  Widget exercise2() {
    return const Icon(Icons.icecream, color: Colors.green, size: 140);
  }

  Widget exercise3() {
    Container cont = Container(width: 200, height: 200, child:
    Image.network("https://get.wallhere.com/photo/anime-anime-girls-clothing-Platinum-Wind-costume-1600x1200-px-mangaka-540539.jpg"));
    return cont;
  }

  void printFunction() {
    print("Pressed");
  }

  Widget exercise4() {
    TextButton btn = TextButton(onPressed: printFunction, child: const Text("Button"));
    return btn;
  }

  Widget exercise5() {
    Column col = Column(children: [
      Container(child: const Text("Text"), padding: const EdgeInsets.symmetric(horizontal: 10.1, vertical: 2.1), color: Colors.red),
      Container(child: const Icon(Icons.gamepad), margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5), color: Colors.blue)
    ],);
    return col;
  }
}
