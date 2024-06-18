import 'dart:convert';
import 'package:education/templates/middleAssignment/data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _History createState() => _History();

  static fromJson(decode) {}
}

class _History extends State<History> {
  late Future<List<HistoryData>> futureHistoryData;

  @override
  void initState() {
    super.initState();
    futureHistoryData = getHistoryData();
  }

  Future<List<HistoryData>> getHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    final encodeHistoryList = prefs.getStringList('historyData');
    if (encodeHistoryList == null) return [];

    final historyList = encodeHistoryList.map((encodeHistory){
      final decodeHistory = json.decode(encodeHistory);
      return HistoryData.fromJson(decodeHistory);
    }).toList();

    return historyList;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder (
              future: futureHistoryData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); 
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Text('Ошибка при загрузке истории'); 
                } else {
                  final historyDataList = snapshot.data!.reversed.toList();
                  return ListView.builder(
                    itemCount: historyDataList.length, 
                    itemBuilder: (context, index) {
                    final historyData = historyDataList[index];
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(16.0),
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total time: ${historyData.totalTime} min'),
                            const SizedBox(width: 10,),
                            Text('Completed stages: ${historyData.stages}'),
                            const SizedBox(width: 10,),
                            Text('Rating: ${historyData.rating}'),
                            Icon(Icons.star, color: Color.fromARGB(255, 197, 177, 5), size: 20)
                          ],
                        ),
                      ),
                    );
                    },
                  );
                }
              },
        ),
      ),
    );
  }
}
                  

