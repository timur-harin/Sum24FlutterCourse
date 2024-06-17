import 'package:education/templates/middleAssignment/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Симуляция загрузки данных
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/liquid_download.riv',
        ),
      ),
      backgroundColor: Color.fromRGBO(53, 126, 212, 1),
    );
  }
}
