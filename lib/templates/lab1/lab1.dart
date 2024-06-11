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
<<<<<<< HEAD
    return const Text(
      "Hello world!",
      style: TextStyle(
        color: Colors.red,
        fontSize: 50.0,
        fontWeight: FontWeight.w700
      )
=======
    return Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 100, color: Colors.red, fontWeight: FontWeight.bold),
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
=======
    return const FlutterLogo(
      size: 100,
>>>>>>> e62954dd0a09b5882ce38a3e42d385ba256d0577
    );
  }

  Widget exercise2() {
<<<<<<< HEAD
<<<<<<< HEAD
    return const Icon(
      Icons.star,
      size: 50,
      color: Colors.yellow
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage('https://avatars.mds.yandex.net/get-shedevrum/12369909/2b544b05cccb11ee8ad77e2051c0c3c2/orig'),
      width: 1000,
      height: 500,
      fit: BoxFit.cover,
    );
=======
    return Icon(Icons.home, size: 100, color: Colors.blue);
  }

  Widget exercise3() {
    return Image.network(
        "https://www.w-dog.ru/wallpapers/10/1/500321873866125/priroda-les-trava.jpg");
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () {
<<<<<<< HEAD
        print('Pressed');
        },

        child: Text('Button'),
      );
=======
          print('tapped');
        },
        child: const Text('Tap me!'));
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
=======
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise3() {
    return const FlutterLogo(
      size: 100,
    );
  }

  Widget exercise4() {
    return const FlutterLogo(
      size: 100,
    );
>>>>>>> e62954dd0a09b5882ce38a3e42d385ba256d0577
  }

  Widget exercise5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          padding: EdgeInsets.fromLTRB(500, 1, 1, 1),
          margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
          child: const Text(
            "Text in Container in Column",
              style: TextStyle(
              color: Colors.blue,
              fontSize: 30.0,
              fontWeight: FontWeight.w400
            )
          ),
        ),
        Container(

           decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 10,
            ),
          ),

          padding: EdgeInsets.fromLTRB(100, 50, 1, 50),
          margin: EdgeInsets.fromLTRB(100, 100, 500, 100),
          child: const Icon(
            Icons.star,
            size: 50,
            color: Colors.yellow
          )
        ) 
      ]
    );
  }
}
