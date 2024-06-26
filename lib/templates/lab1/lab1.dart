import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/*
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

  /*Widget exercise1() {
    return const Text(
<<<<<<< HEAD
      "Hello, Inno!", style: TextStyle(color: Colors.red, fontSize: 20, fontStyle: FontStyle.italic),

    );
  }*/

  Widget exercise2() {
    return const Icon(Icons.grade, size: 40, color: Colors.yellow,);
  }

  Widget exercise3() {
    Container container = Container(width: 160, height: 160, child: Image.network("https://akvamir72.ru/wa-data/public/shop/products/55/25/2555/images/6590/6590.970.jpg", fit: BoxFit.cover,),);
    return container;
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
    );
  }

  Widget exercise3() {
    return const Image(
      width: 100, height: 100, image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
<<<<<<< HEAD
    TextButton button = TextButton(onPressed: () => print("hello"), child: const Text("press me"));
    return button;
  }

  Widget exercise5() {
    Column column = Column(children: [
      Container(child: Text("People"), padding: EdgeInsets.symmetric(horizontal: 2.2, vertical: 4.6),decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),),
      Container(child: Icon(Icons.supervisor_account_sharp), margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),decoration: BoxDecoration(color: Colors.green),)
    ], );
    return column;
=======
    return TextButton(
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
    );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  }
}


*/