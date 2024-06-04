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
    return const Text(
      "Hello, world!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.green,
        fontWeight: FontWeight.bold
      )
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.phone_android_rounded,
      size: 50,
      color: Colors.purple,
    );
  }

  Widget exercise3() {
    return const Image(
      image: NetworkImage("https://steamuserimages-a.akamaihd.net/ugc/931558048644462852/43896ACB32A364E4F86855909BAEA92CD7136F48/?imw=512&amp;imh=288&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true"),
      width: 400,
      height: 200,
      fit: BoxFit.fitHeight,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: onPressed,
      child: const Text("the кнопкааа"),
    );
  }

  void onPressed() {
    print("Pressed");
  }

  Widget exercise5() {
    return Padding(
            padding: const EdgeInsets.all(10),
            child: 
              Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(
                      width: 5,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text(
                    "text"
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.anchor_rounded,
                    size: 50,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            )
    );
  }
}
