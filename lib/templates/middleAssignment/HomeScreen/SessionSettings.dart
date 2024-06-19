import 'package:flutter/material.dart';


class SessionSettings extends StatefulWidget {
  @override
  _Sessionsettings createState() => _Sessionsettings();
}

class _Sessionsettings extends State<SessionSettings> {
  List<Color> boxes = [];

  void _addBox() {
    setState(() {
      boxes.add(boxes.length % 2 == 0 ? Colors.blue : Colors.red);
    });
  }

  void _removeBox(int index) {
    setState(() {
      boxes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFE0), // Light yellow background
      appBar: AppBar(
        title: Text("AppBar"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Session input box
            TextField(
              decoration: InputDecoration(
                hintText: "Session Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
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
                          decoration: InputDecoration(
                            hintText: "Enter Time",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => _removeBox(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("START"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addBox,
                  child: Text("ADD"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
