import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonHomePage extends StatelessWidget {

  final Function() onTap;

  const ButtonHomePage({super.key,  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(

        minimumSize: const Size(50, 50),
        maximumSize: const Size(50, 50),

        backgroundColor: Color.fromARGB(255, 188, 45, 193),

        elevation: 0, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      
        child: Align(
          alignment: Alignment.center,
          child: Icon(Icons.add, color: Colors.white, size: 20),
      ),
      );
  }
}