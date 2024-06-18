import 'package:flutter/material.dart';


class Showerscreen extends StatelessWidget {
  const Showerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Shower Assistant"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("History"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
          onPressed: (){
              Navigator.pushNamed(context, '/new');
          },
        child: Icon(Icons.add),
      ),


    );
  }
}
