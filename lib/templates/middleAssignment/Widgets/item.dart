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
              _title(),
              _state(),
              const Icon(Icons.timer),
            ]),
          ),
        ),
      )
    );
  }

  Widget _title(){
    return Container();
  }

  Widget _state(){
    return Container();
  }
}