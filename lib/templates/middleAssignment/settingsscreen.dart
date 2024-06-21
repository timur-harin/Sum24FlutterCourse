import 'package:education/templates/middleAssignment/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'custom_animation.dart';
import 'linepainter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<SettingsScreen> with SingleTickerProviderStateMixin{
  late Animation<double> _levelAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _levelAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ).drive(
      Tween<double>(begin: 0, end: 10.0),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void changePage(int page) {
    ref.read(currentSessionProvider.notifier).state = ShowerSession(
      hotStart: _switchValue, 
      intervalsNumber: _currentNumberSliderValue, 
      intervalsDuration: _currentSliderValue);
    ref.read(pageProvider.notifier).state = page;
    _controller.reverse();
  }
  
  bool _switchValue = false;
  int _currentSliderValue = 15;
  int _currentNumberSliderValue = 1;

  Color color1 = Colors.blue;
  Color color2 = Colors.cyan;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _levelAnimation,
      builder: (BuildContext context, Widget? child){
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 20+ _levelAnimation.value*4,
          title: Text("Settings", style: TextStyle(fontSize: _levelAnimation.value*3, color: _switchValue?Colors.white:Color.fromARGB(255, 0, 41, 155), fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: _switchValue?Colors.orange:Colors.cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: _levelAnimation.value*3),
            onPressed: () {
              changePage(0);
            },
            iconSize: 30,
            color: Colors.white,
            padding: EdgeInsets.all(0),
            splashRadius: 25,
            constraints: BoxConstraints(minWidth: 50, minHeight: 50),
            // shape: CircleBorder(),
            ),
        ),
        body:Column(
          children: [
            Expanded(
              child:Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total time: ${(_currentSliderValue*_currentNumberSliderValue/60).floor()}:${(_currentSliderValue*_currentNumberSliderValue%60).toInt()}", style: TextStyle(fontSize: 20),),
                    Container(
                      width: 300,
                      height: 50,
                      child: CustomPaint(
                        painter: ColoredLinePainter(
                          numberOfSegments: _currentNumberSliderValue,
                          startWithRed: _switchValue,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Switch(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.red,
                          activeTrackColor: Colors.orange,
                          inactiveThumbColor: Colors.blue,
                          inactiveTrackColor: Colors.cyan,
                          value: _switchValue,
                          onChanged: (bool value) {
                            setState(() {
                              _switchValue = value;
                              if(value){
                                color1 = Colors.red;
                                color2 = Colors.orange;
                              } else {
                                color1 = Colors.blue;
                                color2 = Colors.cyan;
                              }
                            });
                          },
                        ),
                        Text(
                            _switchValue ? 'First interval: hot' : 'First interval: cold',
                            style: TextStyle(fontSize: 15),
                          ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Text(
                      'Interval duration:${(_currentSliderValue.toInt()/60).floor()} minutes, ${(_currentSliderValue.toInt()%60)} seconds',
                      style: TextStyle(fontSize: 15),
                    ),
                    Slider(
                      activeColor: color2,
                      inactiveColor: color1,
                      value: _currentSliderValue.toDouble(),
                      min: 15,
                      max: 10 * 60,
                      divisions: ((10 * 60)/15).toInt()-1,
                      // label: '${_currentSliderValue.toInt()} секунд',
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value.toInt();
                        });
                      },
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'Number of intervals: ${_currentNumberSliderValue}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Slider(
                      activeColor: color2,
                      inactiveColor: color1,
                      value: _currentNumberSliderValue.toDouble(),
                      min: 1,
                      max: 20,
                      divisions: 29,
                      // label: '${_currentSliderValue.toInt()} секунд',
                      onChanged: (double value) {
                        setState(() {
                          _currentNumberSliderValue = value.toInt();
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: (){
                        changePage(2);
                      }, 
                      child: Text("Start session", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(color2),
                        elevation: WidgetStatePropertyAll(_levelAnimation.value),
                        side: WidgetStatePropertyAll(
                          BorderSide(
                          color: color1,
                          width: 1+_levelAnimation.value*0.3,
                      )
                      ),
                      ) ,
                    )
                  ],
                ),)
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                height: 50,
                child: WaveAnimation(
                  duration: const Duration(seconds: 6),
                  waterPercentage: 1,
                  shift: 0.5,
                  color: _switchValue?Color.fromARGB(190, 255, 153, 0):Color.fromARGB(190, 0, 187, 212),
                  waveHeight: 20,
                  ),
                ),
                SizedBox(
                height:50,
                child: WaveAnimation(
                  duration: const Duration(seconds: 7),
                  waterPercentage: 1,
                  color: _switchValue?Color.fromARGB(190, 255, 60, 46):Color.fromARGB(190, 33, 149, 243)
                  ),
                ),
              ])
          ])
      );
    });
  }
}


