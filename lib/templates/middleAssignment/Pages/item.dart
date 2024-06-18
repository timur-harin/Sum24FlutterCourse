import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child : Card(
        color: const Color.fromARGB(255, 169, 239, 224),
        margin: EdgeInsets.zero,
        elevation: 0.06,
      

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),

          side: BorderSide.none, 
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          child:
          Padding(

            padding: const EdgeInsets.only(left: 8, right: 16, top: 4, bottom: 4),
      
            child: Row(children: <Widget>[
              const Icon(Icons.timer),

              _title(),
              _state(),
              
            ]),
          ),
        ),
      )
    );
  }

  Widget _title(){

    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.center,
      
        children: <Widget>[
        Text(
          'Time: 00:12', 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: Color.fromARGB(255, 0, 0, 0)
        )
      ),
    ]),
    );
  }

  Widget _state(){
    return Container();
  }
}