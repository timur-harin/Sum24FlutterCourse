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

    return const Text(
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      
    
    );

  }
    
  

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 30,
      color: Colors.purple,
    );
  }

 Widget exercise3() {
  return Image.network(
    'https://sportishka.com/uploads/posts/2022-11/1667502411_55-sportishka-com-p-nissan-mini-kuper-instagram-64.jpg',
    width: 100, 
    height: 50,
    
  );
}


  Widget exercise4() {
    return TextButton(
      child: const Text("Press_me"),
      onPressed: (){
          print("Pressed");
      },
    );
  }

 Widget exercise5() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          "text",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      SizedBox(width: 20), 
      Container(
        child: const Icon(Icons.cloud),
          padding: const EdgeInsets.all(30.0),
          decoration: ShapeDecoration(shape: Border.all(color: Colors.yellow, width: 20)),
      ),
    ],
  );
}

}

