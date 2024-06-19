import 'package:education/templates/middleAssignment/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:education/templates/middleAssignment/SessionPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower: Home Page'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPreferences())); 
            }, 
            child: Text('Start New Session')
            ),
          BottomSheet(),
        ],
      ),
      )
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
  
}
class _BottomSheetState extends State<BottomSheet> {
  static const prevSession1 = 'prevSession1';
  static const prevSession2 = 'prevSession2';
  static const prevSession3 = 'prevSession3';

  Future<String> getSession1() async {
    return await _getSession1();
  }

  Future<String> _getSession1() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession1) ?? 'No previous sessions';
  }

  Future<String> getSession2() async {
    return await _getSession2();
  }

  Future<String> _getSession2() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession2) ?? '';
  }

  Future<String> getSession3() async {
    return await _getSession3();
  }

  Future<String> _getSession3() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession3) ?? '';
  }
  
    @override
    Widget build(BuildContext context) {
      return Center(
        child: TextButton(
          child: Text('Previous sessions'),
          onPressed: () {
            showModalBottomSheet(
              context: context, 
              builder: (BuildContext context) {
                return SizedBox(
                  height: 400,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<String>(
                        future: getSession1(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Text('Result: ${snapshot.data}');
                          }
                        },
                      ),
                      FutureBuilder<String>(
                        future: getSession2(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Text('Result: ${snapshot.data}');
                          }
                        },
                      ),
                      FutureBuilder<String>(
                        future: getSession3(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return Text('Result: ${snapshot.data}');
                          }
                        },
                      ),
                      ElevatedButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    ),
                    ],
                  )
                );
              }
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.green, 
            textStyle: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
  }