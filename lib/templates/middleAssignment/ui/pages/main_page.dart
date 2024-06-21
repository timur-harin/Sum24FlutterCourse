import 'package:education/templates/middleAssignment/data/shower_take.dart';
import 'package:education/templates/middleAssignment/providers/tempreture_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/duration_provider.dart';
import '../../providers/cycles_provider.dart';
import '../../providers/shower_take_provider.dart';

const List<Widget> tempreture = <Widget>[
  Text('Cold'),
  Text("Hot")
];


class MainPage extends ConsumerStatefulWidget {
  MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPage();
}

class _MainPage extends ConsumerState<MainPage> {
  final TextEditingController cyclesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  final List<bool> _selectedTempreture = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238,	226, 220, 1),
        title: const Text(
          'Contrast Shower Companion App',
          style: TextStyle(
            color: Color(0xFF123C69),
          ),
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              ref.read(showerTakesProvider.notifier).clearShowerTakes();
            },
          ),
        ],

      ),
      backgroundColor: const Color.fromRGBO(238,	226, 220, 1),
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
                        bottom: BorderSide(color: Color(0xFFAC3B61), width: 0.5),
                        )
                    ),
                    child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${showerTake.name} - ${showerTake.duration}sec - ${showerTake.cycles}cycles - ${showerTake.startTime.day}.${showerTake.startTime.month}.${showerTake.startTime.year} - ${showerTake.startTime.hour}:${showerTake.startTime.minute} - ${showerTake.endTime?.hour}h${showerTake.endTime?.minute}m",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF123C69),
                            ),
                          )
                        ],
                      )
                   )
               ],
             ),
             ElevatedButton(
              onPressed: 
               () { Navigator.of(context).pushNamed('/setupShower'); }, 
              child: 
                const Text("Start Shower"),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFAC3B61)),
                  foregroundColor: WidgetStateProperty.all<Color>(Color(0xFFEEE2DC))
                ),
            )
          ],
        )
      )
    );
  }
}