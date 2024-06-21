import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HistoryItem {
  final DateTime timestamp;
  final int cycles;
  final Thermostat lastTemp;

  HistoryItem({
    required this.timestamp,
    required this.cycles,
    required this.lastTemp,
  });
  HistoryItem.fromBox(Map item)
      : this(
          timestamp: item['timestamp'],
          cycles: item['cycles'],
          lastTemp: Thermostat.parse(item['last_temp'])!,
        );

  Widget buildTitle(BuildContext context) {
    return Text('$cycles cycles, ended in ${lastTemp.name} water');
  }

  Widget buildSubtitle(BuildContext context) {
    return Text(
      '${DateFormat.yMMMd().format(timestamp)} at ${DateFormat.Hms().format(timestamp)}',
    );
  }
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
                final item = HistoryItem.fromBox(box.getAt(index)!);
                return ListTile(
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                );
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
