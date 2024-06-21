import 'package:education/templates/middleAssignment/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(248, 56, 2, 1),
              Color.fromRGBO(255, 255, 255, 1)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 65,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(
                          236, 90, 50, 1), // Foreground color (text color)
                      textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold), // Text style
                      elevation: 5, // Elevation
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPreferences()));
                    },
                    child: Text('Start New Session')),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomSheet(),
            )
          ],
        ),
      ),
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
    return Container(
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: Text('Previous sessions'),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
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
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }
                          },
                        ),
                        FutureBuilder<String>(
                          future: getSession2(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }
                          },
                        ),
                        FutureBuilder<String>(
                          future: getSession3(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(236, 90, 50,
                                  1), // Foreground color (text color)
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold), // Text style
                              elevation: 5, // Elevation
                            ),
                            child: Text('Back'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 231, 92, 6),
              textStyle:
                  const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
            ),
          ),
        ),
      ),
    );
  }
}
