import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sessionScreen.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  int _duration = 10;
  int _interval = 2;
  SessionPhase _selectedPhase = SessionPhase.Hot; // Default phase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(157, 213, 235, 1), // Set background color to blue
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Example width, adjust as needed
          decoration: BoxDecoration(
            color: Colors.white, // White background color for the box
            borderRadius: BorderRadius.circular(10), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Session Duration (minutes)',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  initialValue: _duration.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _duration = int.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Interval Duration (minutes)',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  initialValue: _interval.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _interval = int.parse(value!),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPhase = SessionPhase.Hot;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _selectedPhase == SessionPhase.Hot
                            ? Color.fromRGBO(230, 102, 93, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text('Hot', style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedPhase = SessionPhase.Cold;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _selectedPhase == SessionPhase.Cold
                            ? Color.fromRGBO(157, 213, 235, 1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text('Cold', style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
                
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionScreen(
                            duration: _duration,
                            interval: _interval,
                            startPhase: _selectedPhase,
                          ),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white, // Button background color
                    ),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 25, color: Colors.white), // Button text style
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                    
                      side: BorderSide(
                        color: Colors.black, // Border color
                        width: 0.5, // Border width
                      ),
                    ),
                    ),
                    elevation: MaterialStateProperty.all<double>(5), // Elevation (shadow)
                    shadowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.3)), // Shadow color
                  ),
                  child: Text(
                    'Start Session',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
