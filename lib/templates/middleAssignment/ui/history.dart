import 'package:education/templates/middleAssignment/data/boxes.dart';
import 'package:education/templates/middleAssignment/data/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HistoryItemBuilder {
  final List<Map> history;
  final Box<Map> _historyBox;

  HistoryItemBuilder._({required this.history, required Box<Map> historyBox})
      : _historyBox = historyBox;
  factory HistoryItemBuilder.fromBox(Box<Map> historyBox) {
    var history = historyBox.values.toList()
      ..sort((Map a, Map b) =>
          (b['timestamp'] ?? 0).compareTo(a['timestamp'] ?? 0));
    return HistoryItemBuilder._(history: history, historyBox: historyBox);
  }

  Widget build(BuildContext context, int index) {
    final item = HistoryItem.fromDbItem(history[index]);
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    return ListTile(
      leading: Text(
        '${item.cycles}',
        style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
      ),
      title: Text(
          'cycles, ${twoDigit(item.totalTime.inMinutes)}:${twoDigit(item.totalTime.inSeconds.remainder(60))} total, ended in ${item.lastTemp.name} water'),
      subtitle: Text(
        '${DateFormat.yMMMd().format(item.timestamp)} at ${DateFormat.Hms().format(item.timestamp)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _historyBox.deleteAt(index);
        },
      ),
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
            builder: (context, box, widget) {
              final historyItemBuilder = HistoryItemBuilder.fromBox(historyBox);
              return ListView.separated(
                padding: const EdgeInsets.only(bottom: 75.0),
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  return historyItemBuilder.build(context, index);
                },
                separatorBuilder: (context, index) => const Divider(
                  indent: 64.0,
                  endIndent: 16.0,
                ),
              );
            },
          )
        : const Center(
            child: Text('There\'s nothing yet'),
          );
  }
}
