import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: const Text('Lab 1'),
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
<<<<<<< HEAD
    return const Text(
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 50,
        color: Colors.amber,
        fontWeight: FontWeight.bold
      )

=======
    return Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 100, color: Colors.red, fontWeight: FontWeight.bold),
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
    );
  }

  Widget exercise2() {
<<<<<<< HEAD
    return const Icon(
      Icons.save,
      size: 80,
      color: Color.fromARGB(255, 255, 115, 0)
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s'),
      width: 100,
      height: 100,
      fit: BoxFit.cover
    );
=======
    return Icon(Icons.home, size: 100, color: Colors.blue);
  }

  Widget exercise3() {
    return Image.network(
        "https://www.w-dog.ru/wallpapers/10/1/500321873866125/priroda-les-trava.jpg");
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      onPressed: () {
        print('Pressed');
      },
      child: const Text('Press me')
    );
=======
        onPressed: () {
          print('tapped');
        },
        child: const Text('Tap me!'));
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          color: Colors.yellow,
          child: const Text('Hello World'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.green,
          child: const Icon(Icons.egg),
        )
      ],
    );
  }
}
