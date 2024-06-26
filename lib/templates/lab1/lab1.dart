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
<<<<<<< HEAD

    return const Text(
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      
    
    );

=======
    return const Text(
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold),
        );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  }
    
  

  Widget exercise2() {
    return const Icon(
<<<<<<< HEAD
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

=======
      Icons.favorite,
      size: 100,
      color: Colors.red,
    );
  }

  Widget exercise3() {
    return const Image(
      width: 100, height: 100, image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    );
  }
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
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
=======
      onPressed: printPressed,
      child: const Text('CLICK ME!'),
      );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(color: Colors.blue, padding: const EdgeInsets.all(50), child: const Text("This is home Icon in Container!")),
        Container(color: Colors.red, margin: const EdgeInsets.all(100), child: const Icon(Icons.home)),
      ]
    );
  }
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
}

}

