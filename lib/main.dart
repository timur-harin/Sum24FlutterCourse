import 'package:contrast_shower_app/pages/home_page.dart';
import 'package:contrast_shower_app/pages/timer_page.dart';
import 'package:contrast_shower_app/service/hive_provider.dart';
import 'package:contrast_shower_app/service/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         MultiProvider(providers: [
            ChangeNotifierProvider(
            create: (context) => DataProvider()
            ),
            ChangeNotifierProvider(
              create: (context) => TimerAndTempModel(),
            ),
          ]
        )
      ],
      child: MaterialApp(
        home: const HomePage(),
        routes: {
          'timer_page': (context) => const TimerPage()
        },
      ),
    );
  }
}