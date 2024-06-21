import 'package:flutter/material.dart';
import 'home_page.dart';

class SessionInfoPage extends StatelessWidget {
  final List<CustomEvent> events;

  const SessionInfoPage({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Session Information'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Session ${index + 1}'),
            subtitle: Text(
                'Phase: ${events[index].phase.description}\nDuration: ${events[index].duration.inSeconds} seconds'),
          );
        },
      ),
    );
  }
}
