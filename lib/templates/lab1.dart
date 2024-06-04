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
        title: const Text('Lab 1'),
        backgroundColor: Color.fromARGB(255, 185, 232, 160),
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
    return Text("Hello Flutter!", 
    style: TextStyle(
      fontSize: 40,
      color: Color.fromARGB(255, 114, 144, 97), 
      fontWeight: FontWeight.bold,
    ),);
  }

  Widget exercise2() {
    return Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 114, 144, 97),
      size: 100,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://www.w-dog.ru/wallpapers/6/15/516378149952025/minony-multfilm-troe-zheltye-ochki-kombinezony-gitara-igrushka-mishka-plyushevyj-belyj-fon.jpg',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      style: TextButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 185, 232, 160),
    ),
    child: const Text(
      'Surprise surpise',
      style: TextStyle(
        color: Color.fromARGB(255, 114, 144, 97),
      ),
    ),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          color: Color.fromARGB(255, 185, 232, 160),
          child: Text(
            'Surprise surpise',
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 114, 144, 97),
            )
          ),
          child: Icon(
            Icons.brightness_5,
      color: Color.fromARGB(255, 114, 144, 97),
          )
        ),
      ],
    );
  }
}
