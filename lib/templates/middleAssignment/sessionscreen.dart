import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'storage.dart';
import 'custom_animation.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends ConsumerState<SessionScreen> with TickerProviderStateMixin{
  late Animation<double> _levelAnimation;
  late AnimationController _controller;
  late AnimationController _colorController;

  final _firstWave = ColorTween(
  begin: const Color.fromARGB(190, 33, 149, 243),
  end: const Color.fromARGB(190, 255, 60, 46),
  );


  final _secondWave = ColorTween(
  begin: const Color.fromARGB(190, 0, 187, 212),
  end: const Color.fromARGB(190, 255, 153, 0),
  );

  final _buttonColor = ColorTween(
  begin: const Color.fromARGB(255, 0, 188, 212),
  end: const Color.fromARGB(255, 255, 119, 0),
  );

  final _panel1Color = ColorTween(
  begin: const Color.fromARGB(255, 0, 188, 212),
  end: const Color.fromARGB(255, 255, 153, 0),
  );

  final _panel2Color = ColorTween(
  begin: const Color.fromARGB(255, 9, 86, 127),
  end:  const Color.fromARGB(255, 249, 79, 66),
  );


  bool _isRunning = false;
  
  bool Started = false;

  late ShowerSession session;


  bool hotThem = false;
  int intervalsLeft = 0;
  int intervalsDuration = 0;

  int timeLeft = 0;

  late AudioPlayer _notificationPlayer;
  late AudioPlayer _congratulationPlayer;

  @override
  void initState() {
    super.initState();
    _notificationPlayer = AudioPlayer();
    _congratulationPlayer = AudioPlayer();

    session = ref.read(currentSessionProvider.notifier).state!;
    if(session.hotStart) {
      hotThem = true;
    }
    intervalsLeft = session.intervalsNumber;
    intervalsDuration = session.intervalsDuration;
    timeLeft = session.intervalsNumber*session.intervalsDuration;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _levelAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ).drive(
      Tween<double>(begin: 0, end: 10),
    );

    _colorController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    );

    if(hotThem) {
      changeColor();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void changePage(int page) {
    ref.read(pageProvider.notifier).state = page;
  }

  void saveSession () async{
    int selectedRating = 0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Did you enjoy the session?'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (index) {
                return GestureDetector(
                  onTap: () {
                    selectedRating = index + 1;
                    Navigator.of(context).pop(selectedRating);
                  },
                  child: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.orange,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    session.setEstimation(selectedRating);
    session.setEndTime(session.intervalsNumber*session.intervalsDuration - timeLeft);
    session.setDate();
    ref.read(userHistoryProvider).saveSession(session: session);

    changePage(0);
  }

  void changeColor(){
    if(Started){
      playNotificationSound();
    }
    if(hotThem){
      _colorController.forward();
    } else {
      _colorController.reverse();
    }
  }

  void end(){
   
    if(_timer!=null){
       
      _timer!.cancel();
    }
    if(timeLeft == 0) {
      playCongratulationSound();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: hotThem? Colors.orange : Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Congratulations!'),
            content: Text('You have completed the session. It will be recorded in your history'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  saveSession();
                },
                child: Text('To home screen'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: hotThem? Colors.orange : Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Are you sure?'),
            content: Text("You didn't finish the session. Would you like to continue?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if(Started) {
                    saveSession();
                  }else {
                    changePage(0);
                  }
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    }
  }

  String _formatTime() {
    int minutes = timeLeft ~/ 60;
    int remainingSeconds = timeLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String intervalTime() {
    if(intervalsLeft>0){
      int seconds = timeLeft%intervalsDuration; 
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;
      // print('${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')} - ${timeLeft} % ${intervalsDuration}');
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    else {
      return '00:00';
    }
  }
  void playNotificationSound() async {
    await _notificationPlayer.play(AssetSource('notification.mp3'));
  }

  void playCongratulationSound() async {
    await _congratulationPlayer.play(AssetSource('congratulation.mp3'));
  }

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: _levelAnimation,
      builder: (BuildContext context, Widget? child){
      return AnimatedBuilder(
        animation: _colorController,
        builder: (context, child) {
          final firstWaveC = _firstWave.evaluate(_colorController);
          final secondWaveC = _secondWave.evaluate(_colorController);
          final buttonC = _buttonColor.evaluate(_colorController);
          final panel1C = _panel1Color.evaluate(_colorController);
          final panel2C = _panel2Color.evaluate(_colorController);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            title: Container(
              height: 50,
              width: 130,
              child: Card(
                color: panel1C,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 5, color: panel2C!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(_formatTime(), style: TextStyle(fontSize: 30, color: panel2C, fontWeight: FontWeight.bold)))),
            ),
            centerTitle: true,
            backgroundColor: panel1C,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
              )
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlockSemantics(
                blocking: _isRunning,
                child: FloatingActionButton(
                  onPressed: _isRunning? null: () {
                    end();
                  },
                  elevation: 0.0,
                  backgroundColor: hotThem? Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 255, 119, 0): Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 0, 187, 212),
                  child: Icon(Icons.arrow_back, size :30,color: Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 255, 255, 255)),
                ),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                      height: 50+_levelAnimation.value*43,
                      child: WaveAnimation(
                        duration: Duration(milliseconds: 6000),
                        waterPercentage: 1,
                        shift: 0.5,
                        color: secondWaveC,
                        waveHeight: 20,
                      ),
                    ),
                      SizedBox(
                      height: 50 + _levelAnimation.value*43,
                      child: WaveAnimation(
                        duration: Duration(milliseconds: 7000),
                        waterPercentage: 1,
                        color: firstWaveC,
                      ),
                    ),
                  ]),
                ),
                
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        switchTimer();
                      },
                      style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(Size(100,100)),
                        shape: const WidgetStatePropertyAll(CircleBorder()),
                        backgroundColor: WidgetStatePropertyAll(buttonC),
                        elevation: const WidgetStatePropertyAll(0),
        
                      ),
                      child: (!Started)? const Icon(Icons.play_arrow, size: 50, color: Colors.white) : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(intervalTime(), style: const TextStyle(color:Colors.white),),
                          Icon(_isRunning? Icons.pause: Icons.play_arrow, size: 50,color:Colors.white)
                        ],)
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 180,
                      height: 40,
                      child: Card(
                        color: hotThem?Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 255, 119, 0): Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 0, 187, 212),
                        elevation: 0.0,
                        child: Center(child: Text("${intervalsLeft} intervals left", style: TextStyle(color: Color.fromARGB(((10-_levelAnimation.value)*25.5).toInt(), 255, 255, 255), fontSize: 20),)),
                        ),
                    )
                  ],
                )
              ]),
          )
        );
        });
    });
  }

  void switchTimer() async {
    setState(() {
      if(_isRunning){
        _controller.reverse();
      }else {
        _controller.forward();
      }
      setState((){
        _isRunning = !_isRunning;
      });
      if(!Started) {
        Started = true;
      }
    });
    if(_isRunning){
      _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft--;
      });
      if(timeLeft == 0){
        end();
      }
      if(timeLeft%intervalsDuration == 0 && timeLeft!=0 ){
        setState((){
          intervalsLeft--;
          hotThem = !hotThem;
          changeColor();
        });
        
      }
      });
    }else {
      _timer!.cancel();
    }
  }
}


