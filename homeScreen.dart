import 'package:flutter/material.dart';
import 'selectionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final String? sessionData;
  final int? rating;

  HomeScreen({this.sessionData, this.rating}) : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, Map<String, String>> previousSessionData = {};

  @override
  void initState() {
    super.initState();
    _initializeSessionData();
  }

  Future<void> _initializeSessionData() async {
    if (widget.sessionData != null && widget.rating != null) {
      await _addSessionData(widget.sessionData!, widget.rating!);
    }
    await _loadSessionData();
  }

  Future<void> _addSessionData(String data, int rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateTime = DateTime.now().toIso8601String();
    await prefs.setString('session_data_$dateTime', data);
    await prefs.setInt('session_rating_$dateTime', rating);
    await _loadSessionData(); // Ensure new data is loaded after adding a session
  }

  Future<void> _loadSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    Map<String, Map<String, String>> tempData = {};

    for (String key in keys) {
      if (key.startsWith('session_data_')) {
        String dateTime = key.substring(13); // Remove 'session_data_' prefix
        String? data = prefs.getString(key);
        int? rating = prefs.getInt('session_rating_$dateTime');
        if (data != null && rating != null) {
          tempData[dateTime] = {'data': data, 'rating': rating.toString()};
        }
      }
    }

    setState(() {
      previousSessionData = tempData;
    });
  }

  Future<void> _clearSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Session data cleared!"),
      duration: Duration(seconds: 2),
    ));
    setState(() {
      previousSessionData.clear();
    });
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('HH:mm:ss, dd.MM.yy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 197, 230),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clearSessionData();
        },
        tooltip: 'Clear Database',
        child: Icon(Icons.delete),
        backgroundColor: Color.fromARGB(255, 208, 206, 230),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectionScreen()),
                  );
                  if (result != null) {
                    await _addSessionData(result, 0);
                    await _loadSessionData();  // Ensure new data is loaded after adding a session
                  }
                },
                child: Text('Start New Session'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: previousSessionData.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text('Date & Time of Finish',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Session Data',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text('Rating',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: previousSessionData.entries
                          .map((entry) => DataRow(
                                cells: [
                                  DataCell(Text(_formatDateTime(entry.key))),
                                  DataCell(Text(entry.value['data']!)),
                                  DataCell(Text(entry.value['rating']!)),
                                ],
                              ))
                          .toList()
                          .reversed
                          .toList(),
                    ),
                  )
                : Center(child: Text('No session data available')),
          ),
        ],
      ),
    );
  }
}
