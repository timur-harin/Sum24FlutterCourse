import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/showering_page.dart';
import 'package:intl/intl.dart';
import 'stats_button.dart';
import 'stats_null_page.dart';
import "package:provider/provider.dart";

class StatsPage extends StatefulWidget {
  List<Statistics> stats = [];
  StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  void addStats(String date, String type) {
    widget.stats.add(Statistics(date: date, type: type));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // It wont work unfortunately
    int coldSeconds = Provider.of<ColdShower>(context).coldSeconds ?? 1;
    if (coldSeconds != 1) {
      String type = "";
              if (coldSeconds == 30) {
                type = 'Easy';
              } else if (coldSeconds == 45) {
                type = 'Medium';
              } else if (coldSeconds == 60) {
                type = "Hard";
              } else if (coldSeconds == 2) {
                type = "Test";
              }
              widget.stats.add(Statistics(date: DateFormat('yyyy-MM-dd - HH:mm:ss').format(DateTime.now()), type: type));
              print("pen");
    }
              
    Consumer<ColdShower>(
            builder: (context, value, child) {
              print(value);
              String type = "";
              int coldSeconds = value.coldSeconds ?? 1;
              if (coldSeconds == 30) {
                type = 'Easy';
              } else if (coldSeconds == 45) {
                type = 'Medium';
              } else if (coldSeconds == 60) {
                type = "Hard";
              } else if (coldSeconds == 2) {
                type = "Test";
              }
              widget.stats.add(Statistics(date: DateFormat('yyyy-MM-dd - HH:mm:ss').format(DateTime.now()), type: type));
              return const SizedBox.shrink();
            },
          );
    
    if (widget.stats.isEmpty) {
      return const StatsNullPage();
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        middle: Text('Statistics'),
      ),
      child: Column(
        children: [
          Consumer<ColdShower>(
            builder: (context, value, child) {
              String type = "";
              int coldSeconds = value.coldSeconds ?? 1;
              if (coldSeconds == 30) {
                type = 'Easy';
              } else if (coldSeconds == 45) {
                type = 'Medium';
              } else if (coldSeconds == 60) {
                type = "Hard";
              } else if (coldSeconds == 2) {
                type = "Test";
              }
              widget.stats.add(Statistics(date: DateFormat('yyyy-MM-dd - HH:mm:ss').format(DateTime.now()), type: type));
              print("pen");
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.stats.length,
              itemBuilder: (context, index) {
                return Statistics(
                  date: widget.stats[index].date,
                  type: widget.stats[index].type,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
