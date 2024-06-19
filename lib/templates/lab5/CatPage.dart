import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatPage extends StatefulWidget {
  final int statusCode;

  CatPage({required this.statusCode});

  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Code ${widget.statusCode}'),
      ),
      body: Center(
        child: Image.network('https://http.cat/${widget.statusCode}'),
      ),
    );
  }
}