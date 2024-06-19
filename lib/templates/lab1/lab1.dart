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
<<<<<<< HEAD
<<<<<<< HEAD
    return const FlutterLogo(
      size: 100,
=======
=======
>>>>>>> 0e16554 (lab1 Antipov Dmitrii ISE01)
    return const Text(
      "Hello Flutter!",
      style: TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 40,
          fontWeight: FontWeight.bold),
<<<<<<< HEAD
>>>>>>> 0e16554 (lab1 Antipov Dmitrii ISE01)
=======
>>>>>>> 0e16554 (lab1 Antipov Dmitrii ISE01)
=======
    return const Text(
      "Hello Flutter!",
      style: TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 40,
          fontWeight: FontWeight.bold),
=======
    return const FlutterLogo(
      size: 100,
>>>>>>> e62954dd0a09b5882ce38a3e42d385ba256d0577
>>>>>>> aabd8851028621513bb95f4be40a2ad17353f3ff
    );
  }

  Widget exercise2() {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
    return const Icon(Icons.home,
        size: 200, color: Color.fromARGB(255, 0, 255, 0));
  }

  Widget exercise3() {
    return Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Wiki_Test_Image.jpg/800px-Wiki_Test_Image.jpg",
        width: 100,
        height: 100,
        fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () => (print("Pressed")), child: const Text("press it"));
=======
>>>>>>> aabd8851028621513bb95f4be40a2ad17353f3ff
>>>>>>> eef5ad984679b9491f298faa7bfefabee652cb0b
    return const FlutterLogo(
      size: 100,
=======
    return const Icon(Icons.home,
        size: 200, color: Color.fromARGB(255, 0, 255, 0));
  }

  Widget exercise3() {
    return Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Wiki_Test_Image.jpg/800px-Wiki_Test_Image.jpg",
        width: 100,
        height: 100,
        fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () => (print("Pressed")), child: const Text("press it"));
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 30),
          margin: const EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
              color: Color.fromARGB(0, 32, 72, 87),
              border: Border.all(color: Color.fromARGB(255, 100, 100, 100))),
          child: const Text(
            "Column",
          ),
        ),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 30),
          margin: const EdgeInsets.symmetric(vertical: 50),
          decoration: const BoxDecoration(color: Color.fromARGB(0, 32, 72, 87)),
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Wiki_Test_Image.jpg/800px-Wiki_Test_Image.jpg",
              width: 100,
              height: 100),
        ),
      ],
>>>>>>> 0e16554 (lab1 Antipov Dmitrii ISE01)
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
<<<<<<< HEAD
=======
    return const Icon(Icons.home,
        size: 200, color: Color.fromARGB(255, 0, 255, 0));
  }

  Widget exercise3() {
    return Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Wiki_Test_Image.jpg/800px-Wiki_Test_Image.jpg",
        width: 100,
        height: 100,
        fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(
        onPressed: () => (print("Pressed")), child: const Text("press it"));
>>>>>>> 0e16554 (lab1 Antipov Dmitrii ISE01)
=======
>>>>>>> e62954dd0a09b5882ce38a3e42d385ba256d0577
>>>>>>> aabd8851028621513bb95f4be40a2ad17353f3ff
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 30),
          margin: const EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
              color: Color.fromARGB(0, 32, 72, 87),
              border: Border.all(color: Color.fromARGB(255, 100, 100, 100))),
          child: const Text(
            "Column",
          ),
        ),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 30),
          margin: const EdgeInsets.symmetric(vertical: 50),
          decoration: const BoxDecoration(color: Color.fromARGB(0, 32, 72, 87)),
          child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Wiki_Test_Image.jpg/800px-Wiki_Test_Image.jpg",
              width: 100,
              height: 100),
        ),
      ],
    );
  }
}
