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
<<<<<<< HEAD
    return Text("Hello Flutter!",
      style: TextStyle(color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold)
=======
    return Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 100, color: Colors.red, fontWeight: FontWeight.bold),
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
    );
  }

  Widget exercise2() {
<<<<<<< HEAD
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
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }


  Widget exercise5() {
    return Column(children: [
      Container(child: Text("My text!", style: TextStyle(color:Colors.green, fontSize: 20))),
      Container(child: Icon(Icons.money, size: 50))
  ],
    );
  }
}
