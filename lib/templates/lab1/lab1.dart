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
    return Center(
      child: Text (
        'Hello Flutter!',
        style: TextStyle(
          fontSize: 24,
          color: Colors.teal,
          fontWeight: FontWeight.bold,
        ),
      ),
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
    return Icon(Icons.home);
  }

  Widget exercise3() {
    return  
      Image.network(
  'https://avatars.mds.yandex.net/i?id=d63d013380d720cb8dcd673174d79a0c3f7f5bfb-12164831-images-thumbs&n=13',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(onPressed: () {
      print('tapped');
    },
     child: Text('Tap me!'),
     );
  } 
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
  }
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2

Widget exercise5() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          color: Colors.blue,
        ),
        child: Text(
          'Hello, world!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 16),
      Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          color: Colors.green,
        ),
        child: Icon(
          Icons.home,
          color: Colors.red,
          size: 48,
        ),
      ),
    ],
  );
}
}