import 'package:education/templates/middleAssignment/ui/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'ui/pages/history_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MaterialApp(
    title: 'Middle Assigment',
    debugShowCheckedModeBanner: false,
    home:  HomePage(),
  )));
}

