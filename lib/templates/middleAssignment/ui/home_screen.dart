import 'package:education/templates/middleAssignment/ui/session_preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/shower_session.dart';
import '../data/providers/user_preferences_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Contrast Shower Companion'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionPreferencesScreen()),
                );
              },
              child: Text('Start New Session'),
            ),
            SizedBox(height: 20),
            Text('Session History:'),
            FutureBuilder<List<ShowerSession>>(
              future: Provider.of<UserPreferencesProvider>(context, listen: false).getSessionHistory(),
              builder: (BuildContext context, AsyncSnapshot<List<ShowerSession>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while waiting for data
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Handle error case
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length?? 0,
                    itemBuilder: (context, index) {
                      final session = snapshot.data?[index];
                      return ListTile(
                        title: Text('Session ${session?.id}'),
                        subtitle: Text('Duration: ${session?.duration} minutes'),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
