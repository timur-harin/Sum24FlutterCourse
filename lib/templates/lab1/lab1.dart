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
<<<<<<< HEAD
    return const Text(
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 43,
        color: Color.fromARGB(255, 128, 215, 56),
        fontWeight: FontWeight.normal,
      ),
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
      Icons.home,
      size: 43,
      color: Colors.blueGrey,
    );
=======
    return Icon(Icons.home, size: 100, color: Colors.blue);
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise3() {
    return Image.network(
<<<<<<< HEAD
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZeDjxzRrdZi8UQtbEHQdqCrwETxCz5GwMog&s",
      width: 300,
      height: 300,
    );
=======
        "https://www.w-dog.ru/wallpapers/10/1/500321873866125/priroda-les-trava.jpg");
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      onPressed: () {
        print("Pressed");
      },
        child: Text("Button"),
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
        Container(child: Text("Text")),
        Container(child: Icon(Icons.favorite)),
      ],
    );
  }
}
