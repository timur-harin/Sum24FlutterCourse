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
        title: TextField(
              decoration: InputDecoration(
                hintText: "Session Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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
            Container(
              height: 65,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue[400],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "START",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _addBox,
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
