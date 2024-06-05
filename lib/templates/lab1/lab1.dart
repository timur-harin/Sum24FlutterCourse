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
      "Hello Flutter",
      style: TextStyle(
          color: Colors.lightBlue, fontSize: 30, fontWeight: FontWeight.normal),
    );
  }

  Widget exercise2() {
      return const Icon(
      Icons.wallet,
      color: Colors.cyan,
      size: 10,
    );
  }

  Widget exercise3() {
   return const Image(
      image:NetworkImage("https://sun6-23.userapi.com/s/v1/ig2/u5J3Ar8uphLpQB6qFepysFlL_hAm7pk_9-qbfTODO8rn8qr4ywPKkvKX_bhpORN9nv6Dsk0Tzu37MAzmBrE1MH9S.jpg?size=50x50&quality=95&crop=118,2,697,697&ava=1"),
      
    );
  }

  Widget exercise4() {
    return  TextButton(
        onPressed: (){},
        child: Text("Button")
    );
  }

  Widget exercise5() {
     return Column(children: [
      Container(child: Text("End Lab!", style: TextStyle(color:Colors.redAccent, fontSize: 20))),
      Container(child: Icon(Icons.money, size: 50))
  ],
    );
  }
}
