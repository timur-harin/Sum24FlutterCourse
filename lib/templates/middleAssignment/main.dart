import 'package:auto_size_text/auto_size_text.dart';
import 'package:education/templates/middleAssignment/boxes.dart';
import 'package:education/templates/middleAssignment/sessionshistory.dart';
import 'package:education/templates/middleAssignment/views/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SessionshistoryAdapter());

  boxSessions = await Hive.openBox<Sessionshistory>('sessionBox');

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contrast Showering',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HistoryPage(),
    );
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    
    _scrollController = ScrollController();
      
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    var keys = boxSessions.keys.toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,

      /// Prevents the widget from resizing when the keyboard appears
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 37, left: 3),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.orange.shade100),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange.shade50, 
                  ),
                  height: screenHeight * 0.30,
                  width: screenWidth * 0.39,

                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        'Rating',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'Total time (min.)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'Hot Water (min.)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'Cold Water (min.)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'No. of Cycles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: screenHeight * 0.343,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: boxSessions.length,
                    itemBuilder: (context, index) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                      Sessionshistory sessionshistory =
                          boxSessions.getAt(index);
                      return Column(
                        children: [
                          ///key of a Hive database object
                          ///Date of completing session
                          AutoSizeText(
                            keys[index].substring(0, 10),
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          AutoSizeText(
                            keys[index].substring(11, 16),
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: const Border(
                                  right: BorderSide(color: Colors.amber),
                                  top: BorderSide(color: Colors.amber),
                                  bottom: BorderSide(color: Colors.amber),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.amber.shade50,
                              ),
                              width: screenWidth * 0.196,
                              margin: const EdgeInsets.only(left: 2),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AutoSizeText(
                                    sessionshistory.historyRating.toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    sessionshistory.historyTotalTime.toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    sessionshistory.historyHotWaterDuration
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    sessionshistory.historyColdWaterDuration
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                  ),
                                  AutoSizeText(
                                    sessionshistory.historyNumberOfCycles
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () {
              setState(() {
                boxSessions.clear();
              });
            },
            style: ButtonStyle(
                iconColor:
                    WidgetStatePropertyAll(Colors.deepPurpleAccent[700])),
            icon: const Icon(Icons.delete_outline),
            label: Text(
              'Clear History',
              style: TextStyle(
                color: Colors.deepPurpleAccent[700],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: const Alignment(0.0, -0.5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserPreferences()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.all(13)), // Adjust padding as needed:
                ),
                child: const Text(
                  'Start New Session',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}