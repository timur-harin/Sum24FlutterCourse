import 'package:education/templates/middleAssignment/session_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class SessionSettingsScreen extends StatefulWidget {
  const SessionSettingsScreen({super.key});

  @override
  _SessionSettingsScreenState createState() => _SessionSettingsScreenState();
}




class _SessionSettingsScreenState extends State<SessionSettingsScreen> {
  double _temp = 22.0;
  double _tempCold = 15.0;
  int _timeCold = 0;
  int _timeHot = 0;
  int _time = 0;
  int _countHot = 0;
  int _countCold = 0;
  

  @override
  Widget build(BuildContext context) {
    void updateValues() {
      setState(() {
        _time = _timeCold * _countCold + _timeHot * _countHot;
      });
    }
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Session duration',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 51, 60, 78)),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const SizedBox(width: 25,),
                Text('$_time min', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 25,),
                
              ],
            ),
            const SizedBox(height: 10,),
            const Text(
              'Hot water interval',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 51, 60, 78)),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_timeHot > 0) {
                        _timeHot -= 1;
                        updateValues();
      
                      }
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 25,),
                Text('$_timeHot min', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 25,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _timeHot += 1;
                      updateValues();
              
                    });
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10,),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'quantity: ',
                  style: TextStyle(
                    fontSize: 20, 
                    color: Color.fromARGB(255, 51, 60, 78)
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_countHot > 0) {
                        _countHot -= 1;
                        updateValues();
                      }
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 20,),
                Text('$_countHot', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 20,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _countHot += 1;
                      updateValues();
                    });
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),
                
            ],),
            const SizedBox(height: 10,),
            const Text(
              'Hot water temperature',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 51, 60, 78)),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_temp > 0.0) {
                        _temp -= 0.5;
                      }
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 25,),
                Text('$_temp°C ', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 25,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _temp += 0.5;
                    });
                    
                    
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10,),
            const Text(
              'Cold water interval',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 51, 60, 78)),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_timeCold > 0) {
                        _timeCold -= 1;
                      }
                      updateValues();
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 25,),
                Text('$_timeCold min', style: TextStyle(fontSize: 25),),
                const SizedBox(width: 25,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _timeCold += 1;
                      updateValues();
                    });
                    
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10,),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'quantity: ',
                  style: TextStyle(
                    fontSize: 20, 
                    color: Color.fromARGB(255, 51, 60, 78)
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_countCold > 0) {
                        _countCold -= 1;
                        updateValues();
                      }
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 20,),
                Text('$_countCold', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 20,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _countCold += 1;
                      updateValues();
                    });
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),
                
            ],),
            const SizedBox(height: 10,),
            const Text(
              'Cold water temperature',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 51, 60, 78)),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_tempCold > 0.0) {
                        _tempCold -= 0.5;
                      }
                    });
                    
                  }, 
                  icon: const Icon(Icons.remove, color: Color.fromARGB(255, 5, 64, 174),
                  ),

                ),
                const SizedBox(width: 25,),
                Text('$_tempCold°C ', style: const TextStyle(fontSize: 25),),
                const SizedBox(width: 25,),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _tempCold += 0.5;
                    });
                  }, 
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 5, 64, 174),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 25,),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                fixedSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),

              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SessionPreviewScreen(
                    temp: _temp,
                    tempCold: _tempCold,
                    timeCold: _timeCold,
                    timeHot: _timeHot,
                    countHot: _countHot,
                    countCold: _countCold,
                    time: _time,
                    ),
                  ),
                );
              }, 
              child: const Text(
                'Start', 
                style: TextStyle(color: Colors.white, fontSize: 20), 
              ),
            ),
          ],

        ),
      ),
    );
  }
}