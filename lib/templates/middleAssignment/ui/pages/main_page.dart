import 'package:education/templates/middleAssignment/data/shower_take.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/duration_provider.dart';
import '../../providers/cycles_provider.dart';
import '../../providers/shower_take_provider.dart';


class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final TextEditingController cyclesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              ref.read(showerTakesProvider.notifier).clearShowerTakes();
            },
          ),
        ],

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.max,
               children: [
                 for (ShowerTake showerTake in ref.watch(showerTakesProvider))
                   Container( 
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration:  const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.5),
                        
                        )
                    ),
                    child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(showerTake.name),
                          const SizedBox(width: 10),
                          Text(showerTake.duration.toString()),
                          const SizedBox(width: 10),
                          Text(showerTake.cycles.toString()),
                          const SizedBox(width: 10),
                          Text(showerTake.startTime.toString()),
                          const SizedBox(width: 10),
                          Text(showerTake.endTime.toString()),
                          const SizedBox(width: 10),
                        ],
                      )
                   )  
               ],
             ),

            FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                children: [
                  TextField(
                    controller: cyclesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cycles',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duration',
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(cyclesProvider.notifier).setState(int.parse(cyclesController.text));
                ref.read(durationProvider.notifier).setState(int.parse(durationController.text));
                Navigator.of(context).pushNamed('/takeShower');
              },
              child: const Text('Take a shower!'),
            ),
          ]
        )
      )
    );
  }
}