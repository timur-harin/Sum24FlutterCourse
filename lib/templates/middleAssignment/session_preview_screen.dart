import 'package:education/templates/middleAssignment/active_session_screen.dart';
import 'package:flutter/material.dart';

class TempCard extends StatelessWidget {
  final double temperature;
  final Color backgroundColor;
  final int time;
  final String image;

  const TempCard({
    Key? key,
    required this.temperature,
    required this.time,
    required this.backgroundColor,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('temp: $temperature°C', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
          const SizedBox(width: 30,),
          Text('time: $time min', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
          const SizedBox(width: 30,),
          Image(image: AssetImage(image),)
        ],
      ),
    );
  }
}

class SessionPreviewScreen extends StatefulWidget {
  final double temp;
  final double tempCold;
  final int timeCold;
  final int timeHot;
  final int countHot;
  final int countCold;
  final int time;

    const SessionPreviewScreen({
    Key? key,
    required this.temp,
    required this.tempCold,
    required this.timeCold,
    required this.timeHot,
    required this.countHot,
    required this.countCold,
    required this.time,
  }) : super(key: key);

  @override
  _SessionPreviewScreenState createState() => _SessionPreviewScreenState();
}

class _SessionPreviewScreenState extends State<SessionPreviewScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.countCold + widget.countHot,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: TempCard(
                    temperature: index.isEven? widget.temp : widget.tempCold,
                    time: index.isEven? widget.timeHot : widget.timeCold,
                    backgroundColor: Colors.grey,
                    image: index.isEven? 'assets/red_temp.png' : 'assets/blue_temp.png',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0), 
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: const Size(120, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),

                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveSessionScreen(
                      temp: widget.temp,
                      tempCold: widget.tempCold,
                      timeCold: widget.timeCold,
                      timeHot: widget.timeHot,
                      countCold: widget.countCold,
                      countHot: widget.countHot,
                      time: widget.time,
                    ),
                      ),
                    );
                  }, 
                  child: const Text(
                    'Start', 
                    style: TextStyle(color: Colors.white, fontSize: 20), 
                  ),
              ),
          ),
        ],
      ),
    );
  }
}
