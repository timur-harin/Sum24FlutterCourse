import 'package:flutter/material.dart';
import 'ShowerCycle.dart';
import 'storage.dart';



class ShowerHistory extends StatefulWidget {
  final List<ShowerCycle> showerHistory;
  final LocalStorage localStorage;
  final VoidCallback onDelete;

  const ShowerHistory(
      {super.key, required this.showerHistory, required this.localStorage, required this.onDelete});

  @override
  State<StatefulWidget> createState() => _ShowerHistoryState();
}

class _ShowerHistoryState extends State<ShowerHistory> {

  Future<void> _deleteShowerCycle(int index) async {

    await widget.localStorage.deleteShower(index);
    setState(() {
      widget.showerHistory.removeAt(index);
    });
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final showerHistory = widget.showerHistory;
    print(showerHistory);
    return ListView.builder(
      itemCount: showerHistory.length,
      itemBuilder: (context, index) {
        final cycle = showerHistory[index];
        final totalTime = (cycle.hotWaterMinutes + cycle.coldWaterMinutes) * cycle.numberOfCycles +
            (cycle.includeAdditionalTemperatureChange ? (cycle.startingPhase == 'Hot water' ? cycle.hotWaterMinutes : cycle.coldWaterMinutes) : 0);

        return Card(
          child: ListTile(
            title: Text('${cycle.date}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hot Water: ${cycle.hotWaterMinutes} minutes'),
                Text('Cold Water: ${cycle.coldWaterMinutes} minutes'),
                Text('Cycles: ${cycle.numberOfCycles}'),
                Row(
                  children: [
                    const Text('Additional Half Cycle: '),
                    Checkbox(
                      value: cycle.includeAdditionalTemperatureChange,
                      onChanged: (bool? value) {},
                    ),
                  ],
                ),
                Text('Total Time: $totalTime minutes'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () async {
                await _deleteShowerCycle(index);
              },
            ),
          ),
        );
      },
    );
  }
}