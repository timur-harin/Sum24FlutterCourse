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
    return Text("Hello flutter",
        style: TextStyle(
            color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return Icon(
      Icons.airplanemode_on,
      color: Colors.purple,
      size: 30,
    );
  }

  Widget exercise3() {
    return Image.network(
        'https://sun6-22.userapi.com/q8yASSaZaHir1t6oBZq6R-R6w5zS3YeEwTic3Q/li-4kGCG6d4.jpg'
        ,
        width: 100,
        height: 100,);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {}, child: Text("Button"));
  }

  Widget exercise5() {
    return const Column(
      children: [
        Text("My text",style: TextStyle( color: Colors.amber, fontSize: 26, fontWeight: FontWeight.bold),),
        Icon(
      Icons.airplanemode_on,
      color: Colors.purple,
      size: 30,)
      ],
    );
  }
}
