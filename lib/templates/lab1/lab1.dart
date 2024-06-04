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
        title: const Text('Lab 1'),
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
    TextStyle customStyle = const TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold);

    // Return the Text widget with the custom style applied
    return Text(
      'Hello Flutter!',
      style: customStyle,
    );

  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100,
      color: Colors.black,
    );
  }

  Widget exercise3() {
    String imageUrl = "https://www.w-dog.ru/wallpapers/6/15/516378149952025/minony-multfilm-troe-zheltye-ochki-kombinezony-gitara-igrushka-mishka-plyushevyj-belyj-fon.jpg";
    
    return Image.network(
      imageUrl,
      width: 200,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    void onPressed() {
        print("Pressed");
    };

    // Return the TextButton configured with the onPressed callback
    return TextButton(
      onPressed: onPressed,
      child: Text('Press Me'),
    );
  }

  Widget exercise5() {
    String textContent = 'Hello, Flutter';

    IconData iconData = Icons.star;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10), 
          padding: EdgeInsets.all(8), 
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue), 
            borderRadius: BorderRadius.circular(10), 
          ),
          child: Text(textContent),
        ),
      
        Container(
          margin: EdgeInsets.all(10), 
          padding: EdgeInsets.all(8), 
          decoration: BoxDecoration(
            color: Colors.yellow, 
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData, color: Colors.red),
        ),
      ],
    );
  }
}
