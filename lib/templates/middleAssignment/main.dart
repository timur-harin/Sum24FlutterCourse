import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class CustomEvent {
  final DateTime date;
  final bool isColdEvent;
  Color color;
  Duration duration;

  CustomEvent({
    required this.date,
    required this.isColdEvent,
    this.duration = const Duration(seconds: 0),
    this.color = const Color.fromARGB(115, 244, 54, 54),
  }) {
    if (isColdEvent) {
      color = Colors.blue;
    }
  }

  CustomEvent updateDuration(int seconds) {
    int originalDuration = duration.inSeconds;
    duration = Duration(seconds: originalDuration + seconds);
    return this;
  }

  CustomEvent updateColor() {
    if (duration.inSeconds > 300) {
      color = const Color.fromARGB(194, 179, 247, 78);
    } else if (duration.inSeconds > 150) {
      color = const Color.fromARGB(255, 248, 240, 93);
    } else if (duration.inSeconds < 150) {
      color = const Color.fromARGB(255, 177, 60, 60);
    }
    return this;
  }
}

class _HomePageState extends State<HomePage> {
  final DateTime _currentDate = DateTime.now();

   List<CustomEvent> contrastShowerDays = [
      CustomEvent(date: DateTime(2024, 6, 5), isColdEvent: true)
          .updateDuration(230)
          .updateColor(),
      CustomEvent(date: DateTime(2024, 6, 8), isColdEvent: false)
          .updateDuration(100)
          .updateDuration(300)
          .updateColor(),
      CustomEvent(date: DateTime(2023, 6, 18), isColdEvent: true).updateColor(),
    ];



    EventList customEventsList(List<CustomEvent> contrastShowerDays)

  EventList<Event> events = new EventList<Event>(events: {
    new DateTime(2024, 6, 5),
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
        ),
        body: SafeArea(
          child: Center(
            child: CalendarCarousel<Event>(
              onDayPressed: (date, list) {
                print(date);
              },
              height: 450,
              width: 400,
              prevDaysTextStyle:
                  const TextStyle(color: Color.fromARGB(255, 190, 190, 190)),
              selectedDayBorderColor: const Color.fromARGB(255, 0, 0, 0),
              selectedDayButtonColor: const Color.fromARGB(255, 138, 189, 177),
              minSelectedDate: DateTime(_currentDate.year - 10),
              maxSelectedDate: DateTime(_currentDate.year + 10),
              selectedDateTime: _currentDate,
              iconColor: Colors.black,
              headerTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 20.0),
              weekdayTextStyle:
                  const TextStyle(color: Colors.black, fontSize: 15.0),
              markedDatesMap: customEvents(contrastShowerDays),
              ),
          ),
        ));
  }
}
