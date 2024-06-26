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
    return const Text(
<<<<<<< HEAD
      "Hello, world!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.green,
        fontWeight: FontWeight.bold
      )
    );
=======
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
      Icons.phone_android_rounded,
      size: 50,
      color: Colors.purple,
=======
      Icons.favorite,
      size: 100,
      color: Colors.red,
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
    );
  }

  Widget exercise3() {
    return const Image(
<<<<<<< HEAD
      image: NetworkImage("https://steamuserimages-a.akamaihd.net/ugc/931558048644462852/43896ACB32A364E4F86855909BAEA92CD7136F48/?imw=512&amp;imh=288&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true"),
      width: 400,
      height: 200,
      fit: BoxFit.fitHeight,
=======
      width: 100, height: 100, image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
    );
  }

  printPressed() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
<<<<<<< HEAD
      onPressed: onPressed,
      child: const Text("the кнопкааа"),
    );
=======
      onPressed: printPressed,
      child: const Text('CLICK ME!'),
      );
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
  }

  void onPressed() {
    print("Pressed");
  }

  Widget exercise5() {
<<<<<<< HEAD
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
=======
    return Column(
      children: [
        Container(color: Colors.blue, padding: const EdgeInsets.all(50), child: const Text("This is home Icon in Container!")),
        Container(color: Colors.red, margin: const EdgeInsets.all(100), child: const Icon(Icons.home)),
      ]
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
    );
  }
}
