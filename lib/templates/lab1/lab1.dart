import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
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
<<<<<<< HEAD
    return const Text('Hello Flutter!',
        style: TextStyle(
            color: Color.fromARGB(255, 71, 9, 81),
            fontSize: 50,
            fontWeight: FontWeight.w100));
  }

  Widget exercise2() {
    return const Icon(Icons.wallet,
        size: 116.0, color: Color.fromARGB(255, 130, 54, 144));
  }

  Widget exercise3() {
    return const Image(
        image: NetworkImage(
            "https://lh5.googleusercontent.com/proxy/Ka_H98xVvtbMiCwqOAlBitoYIUPbtbWZFMxktx99siRiFPcq--Ktg6kJ695jn04o1UTXPWa3QcTG9R1orq-hwfBTCVkF"),
        width: 550,
        height: 350,
        fit: BoxFit.cover);
=======
    return Text(
      "Hello Flutter!",
      style: TextStyle(
          fontSize: 100, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return Icon(Icons.home, size: 100, color: Colors.blue);
  }

  Widget exercise3() {
    return Image.network(
        "https://www.w-dog.ru/wallpapers/10/1/500321873866125/priroda-les-trava.jpg");
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(255, 151, 161, 170)),
      ),
      onPressed: () {
        print('Pressed');
      },
      child: const Text('Press me'),
    );
=======
        onPressed: () {
          print('tapped');
        },
        child: const Text('Tap me!'));
>>>>>>> 2f3c4e6363673b6216ba7e9d2cb2df8cab3703f2
  }

  Widget exercise5() {
    return Column(children: [
      Container(
        width: 350,
        height: 200,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 168, 206, 240))),
        child: const Text(
          'BMW',
          style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 71, 9, 81)),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 250,
        height: 150,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color.fromARGB(255, 71, 65, 12)),
            color: Colors.green),
        child: const Icon(Icons.holiday_village,
            color: Color.fromARGB(255, 213, 130, 47)),
      ),
    ]);
  }
}
