import 'package:contrast_shower_app/globaL/const.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Color color;
  final Color textColor;
  bool? allwidth = false;

  MyTextField({
    super.key,
    this.keyboardType,
    required this.labelText,
    required this.controller,
    required this.onChanged,
    required this.color,
    required this.textColor,
    this.allwidth
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: tb5,
      child: SizedBox(
        width: widget.allwidth == true ? size.width * 1 :size.width * 0.9,
        height: size.height * 0.07,
        child: TextField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          style: TextStyle(fontSize: 16, fontWeight: w400, color: widget.textColor),  
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            fillColor: widget.color,
            filled: true,
            labelText: widget.labelText,
            // Updated border properties to ensure rounded corners
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
