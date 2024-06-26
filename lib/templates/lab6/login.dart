import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.title),
=======

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
    //  get from localization
     ""
        ),
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
<<<<<<< HEAD
                labelText: localizations.emailLabel,
=======
                // labelText: get from localization
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
<<<<<<< HEAD
                labelText: localizations.passwordLabel,
=======
                // labelText: get from localization
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
<<<<<<< HEAD
                child: Text(localizations.loginButton),
=======
                child: Text(""),
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 8153cba42d2512afba394f7988dc5f86a4fdccfc
