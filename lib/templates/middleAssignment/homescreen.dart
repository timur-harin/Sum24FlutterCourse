import 'package:flutter/material.dart';
import 'custom_animation.dart';
import 'notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _ScreenState();
}

class _ScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin{
  late Animation<double> _levelAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _levelAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ).drive(
      Tween<double>(begin: 0, end: 10.0),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void closePage() {
    ref.read(pageProvider.notifier).state = 1;
    _controller.reverse();
  }
  


  @override
  Widget build(BuildContext context) {
    bool timeToReload = ref.watch(timeToReloadProvider);
    if(timeToReload) {
      Future.microtask(() {
        ref.read(timeToReloadProvider.notifier).state = false;
        setState((){});
      });
    }
    return AnimatedBuilder(
      animation: _levelAnimation,
      builder: (BuildContext context, Widget? child){
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 20+ _levelAnimation.value*4,
          title: Text("Contrast Shower Companion", style: TextStyle(fontSize: _levelAnimation.value*2, 
            color: const Color.fromARGB(255, 0, 41, 155), fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(userHistoryProvider).removeAllHistory();
                setState(() {});
              }, 
              icon: Icon(Icons.delete_forever, color: Colors.white, size: _levelAnimation.value*3,))
          ],
        ),
        body:Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Widget>>(
                future: ref.read(userHistoryProvider).getList(),
                builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.isEmpty){
                      return const Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Your session history will be here soon", 
                            style:  TextStyle(color: Color.fromARGB(255, 73, 155, 222), fontSize: 20),),
                          Text("There's nothing here yet", 
                            style:  TextStyle(color: Color.fromARGB(255, 73, 155, 222), fontSize: 12),),
                        ],
                      ),);
                    }
                    else{
                      return ListView(children: snapshot.data!);
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                height: 50+ _levelAnimation.value*14,
                child: const WaveAnimation(
                  duration: Duration(seconds: 6),
                  waterPercentage: 1,
                  shift: 0.5,
                  color: Color.fromARGB(159, 0, 187, 212),
                  waveHeight: 20,
                  ),
                ),
                SizedBox(
                height:50 + _levelAnimation.value*14,
                child: const WaveAnimation(
                  duration: Duration(seconds: 7),
                  waterPercentage: 1,
                  color: Color.fromARGB(190, 33, 149, 243)
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: const WidgetStatePropertyAll(CircleBorder()),
                    backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 33, 93, 243)),
                    shadowColor: const WidgetStatePropertyAll(Colors.black),
                    elevation: WidgetStatePropertyAll(_levelAnimation.value),
                    side: WidgetStatePropertyAll(
                      BorderSide(
                      color: const Color.fromARGB(255, 19, 0, 222),
                      width: 1+_levelAnimation.value*0.3,
                      ),
                    ),
                  ),
                  onPressed: () {
                    closePage();
                  },
                  child: Icon(Icons.play_arrow,
                    size: _levelAnimation.value*7,
                    color: Colors.white,),
                )
              ])
          ])
      );
    });
  }
}