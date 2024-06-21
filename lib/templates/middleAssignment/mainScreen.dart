import 'package:education/templates/middleAssignment/showerSession.dart';
import 'package:education/templates/middleAssignment/summaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget{
  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final stories = ref.watch(storyNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion', style: TextStyle(fontSize: 30.0),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Priveous sessions:", style: TextStyle(fontSize: 20),),
            StoryListWidget(display: stories),

          ],
        ),
      ),
      backgroundColor: Colors.cyanAccent,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, '/SetUp');
        },
        backgroundColor: Colors.greenAccent,
        label: Text("Start new session", style: TextStyle(fontSize: 15.0),),
        elevation: 0.0,
      ),
    );
  }
}

class DataStorage{
  static List<HistoryBox> data = [];
}

class SessionStoryWidget extends StatelessWidget{
  late HistoryBox box;
  SessionStoryWidget({super.key, required box});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(box.day ?? "Today"),
          Text(box.dayTime ?? "Just now"),
          TextButton(onPressed: (){
            DataHelper.infoList = box.phases;
            Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => SummaryScreen(time: box.completeTime)));
          }, child: Text("View"))
        ],
      ),);
  }
}
class StoryListWidget extends StatefulWidget{
  List<HistoryBox> display;
  StoryListWidget({super.key, required this.display});

  @override
  State<StatefulWidget> createState() => StoryList(display: display);

}
class StoryList extends State<StoryListWidget>{
  List<Widget> stories = [];
  List<HistoryBox> display;
  StoryList({required this.display}){
    for(HistoryBox box_ in display){
      stories.add(SessionStoryWidget(box: box_));
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      stories = [Text("aboba")];
      for(HistoryBox box_ in DataStorage.data.reversed){
        stories.add(SessionStoryWidget(box: box_));
      }
    });
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: stories.length,
      itemBuilder: (context, index) => stories[index],
    );//
  }
}

final storyNotifierProvider = NotifierProvider<StoryNotifier, List<HistoryBox>>((){
  return StoryNotifier();
});


class StoryNotifier extends Notifier<List<HistoryBox>>{
  @override
  List<HistoryBox> build() {
    return DataStorage.data;
  }
}


