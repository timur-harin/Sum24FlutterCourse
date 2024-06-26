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
    return const Text(
<<<<<<< HEAD
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return const Icon(Icons.home, size: 100, color: Colors.black

=======
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold),
        );
  }

  Widget exercise2() {
    return const Icon(
      Icons.favorite,
      size: 100,
      color: Colors.red,
>>>>>>> 06b819c975f7048f6a8559e93db130e7b49f4c3f
    );
  }

  Widget exercise3() {
<<<<<<< HEAD
    return Image.network('data:image/jpeg;base64,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');
  
=======
    return const Image(
      width: 100, height: 100, image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    );
>>>>>>> 06b819c975f7048f6a8559e93db130e7b49f4c3f
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      onPressed: (){
        print('Pressed');
      }, 
      child: const Text('Button')

    );

  }

  Widget exercise5() {
    return Column(children: [
      Container(
              child: const Text(
                "Hello, Flutter!",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Container(
              child: Icon(Icons.ac_unit),
            ),
          ]
=======
      onPressed: printPressed,
      child: const Text('CLICK ME!'),
      );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(color: Colors.blue, padding: const EdgeInsets.all(50), child: const Text("This is home Icon in Container!")),
        Container(color: Colors.red, margin: const EdgeInsets.all(100), child: const Icon(Icons.home)),
      ]
>>>>>>> 06b819c975f7048f6a8559e93db130e7b49f4c3f
    );
  }
}