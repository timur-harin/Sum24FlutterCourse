import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
    return const Text("Hello Flutter!",
        style: TextStyle(
            fontSize: 100, color: Colors.cyan, fontWeight: FontWeight.w900));
  }

  Widget exercise2() {
    return const Icon(
      Icons.adjust_sharp,
      size: 100,
      color: Colors.orange,
    );
  }

  Widget exercise3() {
    Image image = Image.network(
      "https://www.positive.news/wp-content/uploads/2022/03/GOLD-%C2%A9-Sam-Wilson-min.jpg",
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );

    return image;
  }

  Widget exercise4() {
    TextButton button = TextButton(
        onPressed: () {
          print('You pressed the button');
        },
        child: const Text('Pressed'));
    return button;
  }

  Widget exercise5() {
    Column column = Column(
      children: [
        Container(
            child: Text("This is a text"),
            width: 250,
            height: 50,
            padding: EdgeInsets.all(16),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26))),
        Container(
          child: Icon(Icons.access_alarm),
          width: 250,
          height: 50,
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.brown, border: Border.all(color: Colors.black26)),
        )
      ],
    );
    return column;
  }
}
