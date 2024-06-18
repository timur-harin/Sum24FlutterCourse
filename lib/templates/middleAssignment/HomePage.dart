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

  Future<String> getSession() async {
    return await _getSession();
  }

  Future<String> _getSession() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(prevSession1) ?? 'No previous sessions';
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
                        future: getSession(),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
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