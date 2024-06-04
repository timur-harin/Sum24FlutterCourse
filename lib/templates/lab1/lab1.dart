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
      "Hello, Inno!", style: TextStyle(color: Colors.red, fontSize: 20, fontStyle: FontStyle.italic),

    );
  }

  Widget exercise2() {
    return const Icon(Icons.grade, size: 40, color: Colors.yellow,);
  }

  Widget exercise3() {
    Container container = Container(width: 160, height: 160, child: Image.network("https://akvamir72.ru/wa-data/public/shop/products/55/25/2555/images/6590/6590.970.jpg", fit: BoxFit.cover,),);
    return container;
  }

  Widget exercise4() {
    TextButton button = TextButton(onPressed: () => print("hello"), child: const Text("press me"));
    return button;
  }

  Widget exercise5() {
    Column column = Column(children: [
      Container(child: Text("People"), padding: EdgeInsets.symmetric(horizontal: 2.2, vertical: 4.6),decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),),
      Container(child: Icon(Icons.supervisor_account_sharp), margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),decoration: BoxDecoration(color: Colors.green),)
    ], );
    return column;
  }
}


