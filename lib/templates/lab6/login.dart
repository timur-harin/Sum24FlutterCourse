import 'package:education/templates/lab6/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  
  
  LoginScreen({super.key, required this.changing});

  void Function(Locale locale) changing;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
    //  get from localization
        AppLocalizations.of(context)!.title,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') {
                changing(const Locale('en'));
              } else {
                changing(const Locale('ru'));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'en',
                  child: Text('English'),
                ),
                const PopupMenuItem<String>(
                  value: 'ru',
                  child: Text('Russian'),
                ),
              ];
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
                // labelText: get from localization
                labelText: AppLocalizations.of(context)!.username,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // labelText: get from localization
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.login),
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
}
