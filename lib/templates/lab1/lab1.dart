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
      "Hello Flutter!", 
      style: TextStyle(fontSize: 30, 
      fontWeight: FontWeight.bold, 
      color: Color.fromARGB(255, 98, 180, 22)
      )
      );
  }

  Widget exercise2() {
    return const Icon(Icons.home, size: 140, color: Colors.amber);
  }

  Widget exercise3() {
    return Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
    width: 300,
    height: 400,
    fit: BoxFit.cover
    );
  }



  Widget exercise4() {
    return  TextButton(onPressed: (){
      print('Pressed');
    },
    child: const Text("Tap me"));
  }

  Widget exercise5() {
    return Column(children: [Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color.fromARGB(255, 116, 96, 229), borderRadius: BorderRadius.circular(10),),  
      child: const Text("Hello"),), 
      Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(color: const Color.fromARGB(255, 231, 21, 21), borderRadius: BorderRadius.circular(10),),
      child: Icon(Icons.home))]);

  }
}
