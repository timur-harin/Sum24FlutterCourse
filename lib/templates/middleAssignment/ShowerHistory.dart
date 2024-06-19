import 'package:flutter/material.dart';
import 'ShowerCycle.dart';

class ShowerHistory extends StatelessWidget {
  final List<ShowerCycle> showerCycles;

  const ShowerHistory({Key? key, required this.showerCycles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < showerCycles.length; i++) {
      print('Shower $i: ${showerCycles[i].hotWaterMinutes}');
    }
    print('amount of showers: ${showerCycles.length}');
    return ListView.builder(
      itemCount: showerCycles.length,
      itemBuilder: (context, index) {
        final cycle = showerCycles[index];
        final totalTime = (cycle.hotWaterMinutes + cycle.coldWaterMinutes) * cycle.numberOfCycles +
            (cycle.includeAdditionalTemperatureChange ? (cycle.startingPhase == 'Hot water' ? cycle.hotWaterMinutes : cycle.coldWaterMinutes) : 0);

        return Card(
          child: ListTile(
            title: Text('Shower Cycle ${index + 1}'),
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
          ),
        );
      },
    );
  }
}