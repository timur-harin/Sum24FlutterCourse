import 'package:education/templates/middleAssignment/custom_animation.dart';
import 'package:flutter/material.dart';
import 'notifier.dart';
import 'homescreen.dart';
import 'settingsscreen.dart';
import 'sessionscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends ConsumerStatefulWidget {
  const MiddleAssigmentApp({super.key});

  @override
  ConsumerState<MiddleAssigmentApp> createState() => _MiddleAssigmentAppState();
}

class _MiddleAssigmentAppState extends ConsumerState<MiddleAssigmentApp> with SingleTickerProviderStateMixin{
  late Animation<double> _levelAnimation;
  late AnimationController _controller;
  late Widget page = Scaffold(appBar: AppBar(
    toolbarHeight: 20,
    backgroundColor: Colors.cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
  ),);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _levelAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ).drive(
      Tween<double>(begin: 0, end: 10.0),
    );  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  

  void changePage(int pageNumber){

    _controller.forward();
    _controller.addStatusListener((status)
    {
      if (status == AnimationStatus.completed) {
        switch (pageNumber){
          case 0:
            setState(() {
              page = HomeScreen();
            });        
            break;
          case 1:
            setState(() {
              page = SettingsScreen();
            });        
            break;
          case 2:
            setState(() {
              page = SessionScreen();
            });        
            break;
          default:
            setState(() {
              page = HomeScreen();
            });        
            break;
        }
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int pageNmber = ref.watch(pageProvider);
    
    changePage(pageNmber);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          page,
          AnimatedBuilder(
            animation: _levelAnimation,
            builder: (BuildContext context, Widget? child){
              if(_levelAnimation.value!=0){
                return Container(
                  height: 90 + _levelAnimation.value*80,
                  child:  
                    Stack(
                    children: [
                      WaveAnimation(
                        duration: Duration(seconds: 6),
                        color: Color.fromARGB((_levelAnimation.value*25.5).toInt(), 33, 149, 243)
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(),
                        child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Contrast Shower", style: TextStyle(fontSize: 30 ,color: Color.fromARGB((_levelAnimation.value*25.5).toInt(), 255, 255, 255))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("Companion", style: TextStyle(fontSize: 30, color: Color.fromARGB((_levelAnimation.value*25.5).toInt(), 255, 255, 255)),),
                            Icon(Icons.shower, color:  Color.fromARGB((_levelAnimation.value*25.5).toInt(), 255, 255, 255), size: 50)
                          ],)
                        ],
                      )),
                    ],
                  ),
                );}
              else{
                return const SizedBox();
              }
            })
        ],
      ),
    );
  }
}