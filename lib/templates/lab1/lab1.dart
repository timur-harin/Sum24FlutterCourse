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
      style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 18, color: Colors.brown),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.account_box_rounded,
      size: 52,
      color: Colors.deepOrangeAccent,
    );
  }

  Widget exercise3() {
    return Image.network(
    'https://pichold.ru/wp-content/uploads/2022/07/8-1.jpg', 
    width: 200, 
    height: 200, 
    fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      TextButton(
        onPressed: () {
          print("Pressed");
        },
        child: const Text('Tap me'),
        
      ),
    ],
  );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5) ,
          decoration: BoxDecoration(
          border: Border.all(color: Colors.greenAccent), 
          color: Color.fromARGB(255, 216, 160, 160), 
        ), 
         child: Text(
          'Capibaraaaaa',
          style: TextStyle(fontSize: 24), 
        ),
        ),
         Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5), 
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.white, 
        ),
        child: Icon(Icons.access_time, color: Colors.purple), 
      ),
      ],

      
    );
  }
}
