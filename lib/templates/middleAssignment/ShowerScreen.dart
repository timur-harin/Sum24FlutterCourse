import 'package:education/templates/middleAssignment/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class Showerscreen extends ConsumerWidget {
  const Showerscreen({super.key});

  @override
  Widget build(BuildContext context,  ref) {
    final sessions = ref.watch(sessionListProvider);
    int count = sessions.length;
    if (count >= 3 ){
      count = 3;
    }
    var animatedBackground = AnimatedContainer(
      duration: Duration(seconds: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.red.withOpacity(0.8),
          ],
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Shower Assistant", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          animatedBackground,
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("History of Sessions", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  LimitedBox(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (context, index) {
                        final session = sessions[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          color: Colors.white.withOpacity(0.7),
                          child: ListTile(
                            title: Text("${session.intervals} intervals ${session.time} seconds ${session.temperature} temperature", style: TextStyle(color: Colors.black)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){
          Navigator.pushNamed(context, '/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
