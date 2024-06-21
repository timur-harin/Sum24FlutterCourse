import 'dart:async';
import 'package:education/templates/middleAssignment/Shower/SessionCounter.dart';
import 'package:education/templates/middleAssignment/Shower/SessionInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../TimerScreen/TimerPage.dart';

class SessionSettings extends ConsumerStatefulWidget {
  @override
  _SessionSettingsState createState() => _SessionSettingsState();
}

class _SessionSettingsState extends ConsumerState<SessionSettings> {
  String name = "New Session";
  List<Color> boxes = [];
  List<TextEditingController> controllers = []; // Controllers for text fields
  TextEditingController sessionTitleController = TextEditingController(); // Controller for session title

  @override
  void initState() {
    super.initState();
    boxes = [Colors.red, Colors.blue];
    controllers = [TextEditingController(), TextEditingController()]; // Initialize controllers
  }

  void _addBox() {
    setState(() {
      if (boxes.isEmpty) {
        boxes.add(Colors.red);
      } else {
        boxes.add(boxes.last == Colors.red ? Colors.blue : Colors.red);
      }
      controllers.add(TextEditingController()); // Add a new controller
    });
  }

  void _removeBox(int index) {
    setState(() {
      int removedTime = int.tryParse(controllers[index].text) ?? 0;
      ref.read(totalSessionTimeProvider.notifier).removeTime(removedTime);
      
      boxes.removeAt(index);
      controllers.removeAt(index); // Remove the corresponding controller
    });
  }

  void _startSession() {
    if (_isFormValid()) {
      int totalTime = 0;
      List<SessionInfo> sessions = [];
      for (var controller in controllers) {
        int time = int.tryParse(controller.text) ?? 0;
        totalTime += time;
        ref.read(totalSessionTimeProvider.notifier).addTime(time);

        SessionInfo session = SessionInfo(time: time, color: boxes[controllers.indexOf(controller)], realTime: time);
        sessions.add(session);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerPage(name: name, totalTime: totalTime, sessions: sessions),
        ),
      );
    }
  }


  bool _isFormValid() {
    if (sessionTitleController.text.isEmpty) {
      return false;
    }
    for (var controller in controllers) {
      if (controller.text.isEmpty || int.tryParse(controller.text) == null) {
        return false;
      }
    }
    if (controllers.length == 0) {
      return false;
    }
    return true;
  }

  List<int> times = [0, 0];
  @override
  Widget build(BuildContext context) {
    final totalSessionTime = ref.watch(totalSessionTimeProvider);
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0), // Light yellow background
      appBar: AppBar(
        title: TextField(
          controller: sessionTitleController, // Assign controller
          decoration: InputDecoration(
            hintText: "Session Title",
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (text) {
            setState(() {
              name = text;
            }); // Rebuild the widget when the text changes
          },
        ),
        backgroundColor: Colors.blue[400],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: boxes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: boxes[index],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: TextField(
                          controller: controllers[index], // Assign controller
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Enter Time",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {}); // Rebuild the widget when the text changes
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            _removeBox(index);
                          }
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 65,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue[400],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: _isFormValid() ? _startSession : null, // Disable if form is not valid
                    child: Text(
                      "START",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _addBox();
                      });
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

}
