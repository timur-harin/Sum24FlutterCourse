import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:education/templates/middleAssignment/HomeScreen/DataSaver.dart' as data_saver;


class TimerPage extends StatefulWidget {
  final String name;
  final int totalTime;
  final List<SessionInfo> sessions;

  TimerPage({required this.name, required this.totalTime, required this.sessions});

  @override
  _TimersState createState() => _TimersState();
}

class _TimersState extends State<TimerPage> {
  late int _remainingTime;
  late bool _isRunning;
  late bool _isPaused;

  late int _sessionIndex = 0;
  late int _toNext;

  late int _sessionTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.totalTime * 60;
    _toNext = widget.sessions[_sessionIndex].time * 60;
    _isRunning = true;
    _isPaused = false;

    _sessionTime = widget.totalTime;
    _startTimer();
  }

  void _startTimer() {
    if (_remainingTime > 0) {
      Future.delayed(Duration(seconds: 1), () {
        if (_isRunning && !_isPaused) {
          setState(() {
            _remainingTime--;
            _toNext--;
            if (_toNext == 0) {
              widget.sessions[_sessionIndex].realTime = widget.sessions[_sessionIndex].time * 60;
              _sessionIndex++;
              if (_sessionIndex < widget.sessions.length) {
                _toNext = widget.sessions[_sessionIndex].time * 60;
              }
            }
            if (_remainingTime == 0) {

              _onTimerComplete();
            }
          });
          _startTimer();
        }
      });
    } else {
      // widget.sessions[_sessionIndex].realTime = widget.sessions[_sessionIndex].time * 60;
      _saveOrCancel();
    }
  }

  void _onTimerComplete() {
    _cancelTimer();
  }

  void _stopTimer() {
    setState(() {
      _isPaused = true;
    });
  }

  void _skipTimer() {
    widget.sessions[_sessionIndex].realTime = (widget.sessions[_sessionIndex].time * 60) - _toNext;
    setState(() {
      if (_sessionIndex < widget.sessions.length - 1) {
        _remainingTime -= _toNext;
        _sessionTime -= _toNext;
        _toNext = widget.sessions[++_sessionIndex].time * 60;
      } else if (_sessionIndex == widget.sessions.length - 1) {
        _cancelTimer();
      }
    });
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
      _startTimer();
    });
  }

  void _cancelTimer() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Cancel",
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        widget.sessions[_sessionIndex].realTime = (widget.sessions[_sessionIndex].time * 60) - _toNext;       
        for (int i = _sessionIndex + 1; i < widget.sessions.length; i++) {
          widget.sessions[i].realTime = 0;
        } 
        return _saveOrCancel();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
    _stopTimer();
  }

  Widget _saveOrCancel() {
    int overallTime = 0;
    for (var session in widget.sessions) {
      overallTime += session.realTime;
    }
    return Scaffold(
      backgroundColor: _getColor(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: _getColor(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do you want to save this session?',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'NO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: _getColor() == Colors.blue ? Colors.blue[600] : Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => data_saver.DataSaver(name: widget.name, time: Duration(seconds: overallTime), sessions: widget.sessions),
                      //   ),
                      // );
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return data_saver.DataSaver(name: widget.name, time: Duration(seconds: overallTime), sessions: widget.sessions);
                        }
                      );
                      Navigator.popUntil(context, ModalRoute.withName('/')); 
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: _getColor() == Colors.blue ? Colors.blue[600] : Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              _remainingTime > 0 ? 
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'BACK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15.0),
                  backgroundColor: _getColor() == Colors.blue ? Colors.blue[600] : Colors.red[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ) : 
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (_sessionIndex < widget.sessions.length) {
      return widget.sessions[_sessionIndex].color;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');

    final minutesToNextSession = (_toNext ~/ 60).toString().padLeft(2, '0');
    final secondsToNextSession = (_toNext % 60).toString().padLeft(2, '0');

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _getColor(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeBox(minutes, "MINUTES"),
                  SizedBox(width: 20.0),
                  _buildTimeBox(seconds, "SECONDS"),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'To the next session',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$minutesToNextSession:$secondsToNextSession',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isPaused ? _cancelTimer : _skipTimer,
                    child: Text(
                      _isPaused ? "CANCEL" : "SKIP",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getColor() == Colors.blue ? Colors.blue[600] : Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: _isPaused ? _resumeTimer : _stopTimer,
                    child: Text(
                      _isPaused ? "RESUME" : "STOP",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getColor() == Colors.blue ? Colors.blue[600] : Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isRunning = false;
    super.dispose();
  }

  Widget _buildTimeBox(String time, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 48.0,
              color: _getColor(),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
