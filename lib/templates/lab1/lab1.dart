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
<<<<<<< HEAD
    return Text(
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return Icon(
      Icons.home,
=======
    return const Text(
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
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
<<<<<<< HEAD
    return Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Zunge_raus.JPG/300px-Zunge_raus.JPG',
      width: 150,
      height: 250,
      fit: BoxFit.cover,
=======
    return const Image(
      width: 100, height: 100, image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
    );
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      onPressed: () => print('Pressed'),
      child: Text(
        'Pressed',
      ),
    );
=======
      onPressed: printPressed,
      child: const Text('CLICK ME!'),
      );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  }

  Widget exercise5() {
    return Column(
      children: [
<<<<<<< HEAD
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
          ),
          child: Text(
            'Hello Flutter!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
          ),
          child: Icon(
            Icons.home,
            size: 50,
            color: Colors.red,
          ),
        ),
      ],
=======
        Container(color: Colors.blue, padding: const EdgeInsets.all(50), child: const Text("This is home Icon in Container!")),
        Container(color: Colors.red, margin: const EdgeInsets.all(100), child: const Icon(Icons.home)),
      ]
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
    );
  }
}
