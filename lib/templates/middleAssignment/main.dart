import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models.dart';
import 'home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShowerSessionAdapter());
  Hive.registerAdapter(TemperaturePhaseAdapter());
  Hive.registerAdapter(UserPreferencesAdapter());

  await Hive.openBox<ShowerSession>('sessions');
  await Hive.openBox<UserPreferences>('preferences');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.lightBlueAccent, 
    background: Colors.white, 
  ),
  textTheme: TextTheme(
    headlineLarge : TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

class PhaseTransitionWidget extends StatefulWidget {
  final String phaseType;

  PhaseTransitionWidget({required this.phaseType});

  @override
  _PhaseTransitionWidgetState createState() => _PhaseTransitionWidgetState();
}

class _PhaseTransitionWidgetState extends State<PhaseTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: widget.phaseType == 'hot' ? Colors.red : Colors.blue,
      end: widget.phaseType == 'hot' ? Colors.blue : Colors.red,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          color: _colorAnimation.value,
        );
      },
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;

  GradientButton({required this.text, required this.onPressed, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Smaller rounded corners
        ),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 242, 243, 244), Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: width, 
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10), 
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 14), 
          ),
        ),
      ),
    );
  }
}
class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  CircularIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(144, 235, 239, 242), const Color.fromARGB(255, 255, 255, 255)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        onPressed: onPressed,
        iconSize: 30,
        padding: EdgeInsets.all(10), 
      ),
    );
  }
}