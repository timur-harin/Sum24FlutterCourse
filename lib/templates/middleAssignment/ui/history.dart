import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HistoryItemBuilder {
  final Box historyBox;
  final int index;
  final DateTime timestamp;
  final int cycles;
  final Thermostat lastTemp;

  HistoryItemBuilder._({
    required this.timestamp,
    required this.cycles,
    required this.lastTemp,
    required this.historyBox,
    required this.index,
  });
  factory HistoryItemBuilder.fromBox(Box historyBox, int index) {
    final item = historyBox.getAt(index);
    return HistoryItemBuilder._(
      timestamp: item['timestamp'],
      cycles: item['cycles'],
      lastTemp: Thermostat.parse(item['last_temp'])!,
      historyBox: historyBox,
      index: index,
    );
  }

  Widget build(BuildContext context) => ListTile(
        leading: Text(
          '$cycles',
          style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
        ),
        title: Text('cycles, ended in ${lastTemp.name} water'),
        subtitle: Text(
          '${DateFormat.yMMMd().format(timestamp)} at ${DateFormat.Hms().format(timestamp)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            historyBox.deleteAt(index);
          },
        ),
      );
}

class SessionHistoryList extends ConsumerWidget {
  const SessionHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyBox = Hive.box<Map>(Boxes.history);
    return historyBox.values.isNotEmpty
        // TODO implement removing items by selection of list items
        ? ValueListenableBuilder(
            valueListenable: historyBox.listenable(),
            builder: (context, box, widget) => ListView.separated(
              padding: const EdgeInsets.only(bottom: 75.0),
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                return HistoryItemBuilder.fromBox(historyBox, index)
                    .build(context);
              },
              separatorBuilder: (context, index) => const Divider(
                indent: 64.0,
                endIndent: 16.0,
              ),
            ),
          )
        : const Center(
            child: Text('There\'s nothing yet'),
          );
  }
}
