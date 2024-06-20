import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'active_session_screen.dart';
import 'theme.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  int hotDuration = 30;
  int coldDuration = 30;

  void _selectDuration(BuildContext context, bool isHot) async {
    int? selectedDuration = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int tempDuration = isHot ? hotDuration : coldDuration;
        return AlertDialog(
          title: Text(isHot ? 'Select Hot Duration' : 'Select Cold Duration'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 120,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('${index + 1} seconds'),
                        onTap: () {
                          Navigator.pop(context, index + 1);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedDuration != null) {
      setState(() {
        if (isHot) {
          hotDuration = selectedDuration;
        } else {
          coldDuration = selectedDuration;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Set Your Session Preferences', style: Theme.of(context).textTheme.headlineLarge)),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Hot Duration: $hotDuration seconds'),
              trailing: ElevatedButton(
                onPressed: () => _selectDuration(context, true),
                child: Text('Set'),
              ),
            ),
            ListTile(
              title: Text('Cold Duration: $coldDuration seconds'),
              trailing: ElevatedButton(
                onPressed: () => _selectDuration(context, false),
                child: Text('Set'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      hotDuration: hotDuration,
                      coldDuration: coldDuration,
                    ),
                  ),
                );
              },
              child: Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
