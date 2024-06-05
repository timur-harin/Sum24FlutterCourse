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
<<<<<<< HEAD:lib/templates/lab1.dart

    return const Text(
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      
    
=======
    return Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 100, color: Colors.red, fontWeight: FontWeight.bold),
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2:lib/templates/lab1/lab1.dart
    );

  }
    
  

  Widget exercise2() {
<<<<<<< HEAD:lib/templates/lab1.dart
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
=======
    return Icon(Icons.home, size: 100, color: Colors.blue);
  }

  Widget exercise3() {
    return Image.network(
        "https://www.w-dog.ru/wallpapers/10/1/500321873866125/priroda-les-trava.jpg");
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () {
          print('tapped');
        },
        child: const Text('Tap me!'));
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2:lib/templates/lab1/lab1.dart
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

