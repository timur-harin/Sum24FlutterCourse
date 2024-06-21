import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets.dart';


class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contrast Shower"),
      ),

      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xFF3366FF),
        //       Color(0xFF00CCFF),
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     stops: [0.0, 1.0],
        //   )
        // ),

        child: const Center(
            child: ShowerSessionListWidget()
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
            "Start new session"
        ),
        icon: const Icon(Icons.add),
        onPressed: () => {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {return const SessionSettingsWidget();}
          )

          // ref
          //     .read(showerSessionsProvider.notifier)
          //     .addSession()
        },
      ),
    );
  }
}


class NewSessionSettingsScreen extends ConsumerWidget {
  const NewSessionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Session settings")
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Start session"),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: const Center(
        child: Column(
          children: <Widget>[
            Text(
              "Start phase",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            StartPhaseChoiceWidget(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phase duration",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    PhaseDurationWidget(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phases amount",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    PhasesAmountWidget(),


                  ],
                )

              ],
            ),




            

          ],
        ),
      ),

    );
  }
}

class ShowerSessionScreen extends ConsumerWidget {
  const ShowerSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CountdownWidget()
          ),
          SizedBox(height: 20),
          Center(
            child: CountdownControlsWidget(),
          )
        ],


      ),


    );
  }
}


class ShowerSessionOverviewScreen extends ConsumerWidget {
  const ShowerSessionOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(

    );
  }
}