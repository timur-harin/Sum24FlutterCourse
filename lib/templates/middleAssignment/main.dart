import 'package:education/templates/middleAssignment/screens/homeScreen.dart';
import 'package:education/templates/middleAssignment/screens/postSessionScreen.dart';
import 'package:education/templates/middleAssignment/screens/sessionPreferencesScreen.dart';
import 'package:education/templates/middleAssignment/screens/sessionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('sessionBox');

  runApp(ProviderScope(
    child: MaterialApp(
      
    theme: ThemeData(
    useMaterial3: true,

    // Define the default brightness and colors.
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      // ···
      brightness: Brightness.light,
    ),

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      displayLarge: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),

    ),
  ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/session_preferences': (context) => const SessionPreferencesScreen(),
        '/session': (context) => const SessionScreen(),
        '/post_session': (context) => const PostSessionScreen(),
      },  
    ),
  ));
}

