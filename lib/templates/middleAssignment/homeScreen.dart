import 'package:education/templates/middleAssignment/ShowerHistory.dart';
import 'package:education/templates/middleAssignment/storage.dart';
import 'package:flutter/material.dart';
import 'CycleSettingsScreen.dart';
import 'ShowerCycle.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>{
  LocalStorage localStorage = LocalStorage();
  int numberOfShowers = 0;
  List<ShowerCycle> showerHistory = [];

  @override
  void initState() {
    super.initState();
    // _loadNumberOfShowers();
    _loadShowerHistory();
  }

  @override void didChangeDependencies() {
    super.didChangeDependencies();
    // _loadNumberOfShowers();
    _loadShowerHistory();
  }

  // void _loadNumberOfShowers() async {
  //   await localStorage.loadNumberOfShowers();
  //   setState(() {
  //     numberOfShowers = localStorage.numberOfContrastShowers;
  //   });
  // }
  void _loadShowerHistory() async {
    List<ShowerCycle> history = await localStorage.getAllShowers();
    setState(() {
      showerHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Contrast Shower Manager",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "History",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            Expanded(
              child: ShowerHistory(showerCycles: showerHistory),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CycleSettingsScreen())
          );
          if (result == true) {
            _loadShowerHistory();
          }
        },
        backgroundColor: Colors.blue,

        child: const Icon(
          Icons.shower_outlined,
          color: Colors.white,
        ),
      ),
    );
  }


}