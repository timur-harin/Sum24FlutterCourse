import 'dart:collection';
import 'dart:math';

import 'package:education/templates/middleAssignment/Widgets/setting.dart';
import 'package:flutter/material.dart';

import 'Shower.dart';
import 'providerS.dart';


class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromARGB(255, 232, 178, 236),
      appBar: AppBar(

        title: const Text('Home Page'),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Color.fromARGB(255, 232, 178, 236)

      ),

      body: Center(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          
          children: [

            Padding(

              padding: EdgeInsets.all(8.0),

              child: TextField(

                decoration: const InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: 'Enter time for cycle, please <3',

                ),

                keyboardType: TextInputType.number,
                controller: controller,

              ),

            ),


            Padding(

              padding: EdgeInsets.all(8.0),

              child: ElevatedButton(
              
                style: ElevatedButton.styleFrom(iconColor: Color.fromARGB(26, 238, 0, 255),),

                onPressed: () {
                
                Navigator.push(

                  
                  context,
                    MaterialPageRoute(builder: (context) {
                    //workoutProvider.number = int.parse(controller.text);
                    ShowerProvider().time = int.parse(controller.text);
                    return Setting();
                  }),

                );
              },
              
                child: Row(

                  mainAxisSize: MainAxisSize.min,

                  children:[

                    Text('Start Shower ${ShowerProvider().time}'),
                    Icon(Icons.water_drop, color: Color.fromARGB(255, 9, 160, 242),),

                  ],
                ) 
              )
            )
          ]
        ),
      ),
    );
  }
}