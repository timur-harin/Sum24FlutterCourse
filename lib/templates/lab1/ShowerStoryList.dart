import 'package:flutter/material.dart';
import '../middleAssignment/Widgets/item.dart';

class ShowerStoryList extends StatelessWidget {
  const ShowerStoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _list(),
      _updateButton(),

    ]);
  }

  Widget _list(){
    return ListView.separated(
      itemCount: 10,

      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      
      separatorBuilder: (BuildContext context, int index){
        return SizedBox(height: 10);
      },
      itemBuilder: (BuildContext context, int index){
        return const Item();
      },
    );
  }

  Widget _updateButton(){
    return Container();
  }

}