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
      "Hello, flutter!",
      style: TextStyle(
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.favorite,
      size: 40,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    return const Image(
        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw9YtRKVz9bKUSiwFgMt5COEU-FnTaPeUW3g&s'),
      );
  }

  onPressed(){
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(onPressed: onPressed, child: const Text("Press me"));
  }

  Widget exercise5() {
    return  Column(
      children: [
        Container(padding: const EdgeInsets.all(8.0),
                  color: Colors.blue[600],
                  alignment: Alignment.center,
                  child : const Text("text here")),
        Container(alignment: Alignment.bottomLeft,
                  child: const Icon(Icons.sim_card_download, size: 60))
       ],
      
    );
  }
}
