import 'package:education/templates/middleAssignment/screens/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const MiddleAssigmentApp());

const MaterialColor primary = Colors.teal;
const MaterialAccentColor accent = Colors.tealAccent;

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Middle Assigment',
        theme: ThemeData(
          primarySwatch: primary,
        ),
        // TODO - complete assignment
        home: const ProviderScope(
          child: ShowerSessionScreen(),
        ),
      ),
    );
  }
}
