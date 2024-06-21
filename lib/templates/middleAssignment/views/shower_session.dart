import 'dart:async';
import 'package:education/templates/middleAssignment/views/session_summary.dart';
import 'package:education/templates/middleAssignment/views/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShowerSession extends ConsumerStatefulWidget {
  const ShowerSession({super.key});

  @override
  _ShowerSession createState() => _ShowerSession();
}

class _ShowerSession extends ConsumerState<ShowerSession> with SingleTickerProviderStateMixin {
  bool _isRunning = true;
  bool _newPhase = true;
  Timer? _timer;
  int _start = 180;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  /// Default value
  int numberOfCycles = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      final cyclePhase = int.tryParse(ref.read(cyclesProvider)) ?? 0;
      if ((_start == 1 && numberOfCycles < cyclePhase * 2 - 1) || _start == 0) {
        setState(() {
          timer.cancel();

          numberOfCycles++;
          if ((numberOfCycles < cyclePhase * 2)) {
            clicked();
          }
          if (numberOfCycles == cyclePhase * 2) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SessionSummary()),
                );
          }
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void resumeTimer() {
    setState(() {
      _isRunning = true;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic);
    
    ///Ensures the provided callback is called after the widget has been fully built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      clicked();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
     _animationController.dispose();
    super.dispose();
  }

  String get timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void clicked() {
    final hotPhase = ref.read(hotPhaseProvider);
    final coldPhase = ref.read(coldPhaseProvider);

    setState(() {
      if (!_newPhase) {
        _start = int.tryParse(coldPhase)! * 60;
      } else {
        _start = int.tryParse(hotPhase)! * 60;
      }
      _newPhase = !_newPhase;
      _animationController.forward(from: 0.0); // Start the animation

    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final hotPhase = int.tryParse(ref.read(hotPhaseProvider))! * 60;
    final coldPhase = int.tryParse(ref.read(coldPhaseProvider))! * 60;
    final cyclePhase = int.tryParse(ref.read(cyclesProvider)) ?? 0;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _newPhase ? Colors.blue: const Color.fromARGB(243, 221, 23, 9),

      /// Prevents the widget from resizing when the keyboard appears
      body: Stack(
        children: [
          /// Ongoing Phase: Hot Water
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: const Color.fromARGB(243, 221, 23, 9),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    const Positioned(
                      //padding: EdgeInsets.only(top: 100.0),
                      top: 100,
                      child: Text(
                        'Hot Water',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      //padding: const EdgeInsets.only(top: 157),
                      top: 157,
                      child: Text(
                        '${(hotPhase ~/ 60).toString().padLeft(2, '0')}:${(hotPhase % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
              
                    Center(
                      child: AutoSizeText(
                        timerText,
                        style: const TextStyle(
                          fontSize: 150,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                      ),
                    ),
              
                    /// Showing the Next Phase
                    Positioned(
                      bottom: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        width: 365,
                        height: 193, //193
                        alignment: Alignment.bottomCenter,
                        child: const Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Center(
                              child: Text(
                                'Next Phase\n\n\n',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Cold Water',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              
                    /// Button to pause/play ongoing phase
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          _isRunning = false;
                          _timer?.cancel();
              
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
              
                    /// Button to end onling phase
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          if (_isRunning) {
                            pauseTimer();
                          } else {
                            resumeTimer();
                          }
                        },
                        icon: (_isRunning
                            ? const Icon(
                                Icons.pause,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Ongoing Phase: Cold Water
          if (_newPhase)
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  color: Colors.blue,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      const Positioned(
                        //padding: EdgeInsets.only(top: 100.0),
                        top: 100,
                        child: Text(
                          'Cold Water',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 157,
                        //padding: const EdgeInsets.only(top: 157),
                        child: Text(
                          '${(coldPhase ~/ 60).toString().padLeft(2, '0')}:${(coldPhase % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                
                      Center(
                        child: AutoSizeText(
                          timerText,
                          style: const TextStyle(
                            fontSize: 150,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                        ),
                      ),
                
                      /// Containers for showing the Next Phase
                      // End of Timer
                      (numberOfCycles == cyclePhase * 2 - 1)
                          ? Positioned(
                              bottom: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                  // fromCssColor('#242526'),
                                ),
                                width: 365,
                                height: 193,
                                child: const Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Next Phase\n\n\n',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'End of Timer',
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          :
                
                          /// Shwonig the Next Phase
                          Positioned(
                              bottom: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromARGB(243, 221, 23, 9),
                                ),
                                width: 365,
                                height: 193,
                                child: const Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Next Phase\n\n\n',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Hot Water',
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                
                      /// Button to pause/play ongoing phase
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            _isRunning = false;
                            _timer?.cancel();
                
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                
                      /// Button to end onling phase
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            if (_isRunning) {
                              pauseTimer();
                            } else {
                              resumeTimer();
                            }
                          },
                          icon: (_isRunning
                              ? const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}