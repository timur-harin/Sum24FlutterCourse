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
    return Text("Hello Flutter!",
      style: TextStyle(color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold)
    );
  }

  Widget exercise2() {
    return Icon(Icons.home,
      size: 30,
      color: Colors.brown
    );
  }

  Widget exercise3() {
    return Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa-37zTBxUjRLwHqp_sLMppBNNC5ZmhEj5SA&s",
    width: 200,
    height: 200,
    fit: BoxFit.cover
    );
  }

  Widget exercise4() {
    return TextButton(onPressed: (){print("Pressed");}, child: const Text("My Button"));
  }


  Widget exercise5() {
    return Column(children: [
      Container(child: Text("My text!", style: TextStyle(color:Colors.green, fontSize: 20))),
      Container(child: Icon(Icons.money, size: 50))
  ],
    );
  }
}
