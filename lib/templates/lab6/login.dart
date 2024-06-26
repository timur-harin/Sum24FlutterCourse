import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'theme.dart';

class LoginScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  LoginScreen({required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.title ?? 'Title'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'en') {
                onLocaleChange(Locale('en'));
              } else if (value == 'ru') {
                onLocaleChange(Locale('ru'));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                PopupMenuItem(
                  value: 'ru',
                  child: Text('Русский'),
                ),
              ];
            },
            icon: Icon(Icons.language),
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
                labelText: localizations?.username ?? 'Username',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: localizations?.password ?? 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(localizations?.login ?? 'Login'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 0, 17, 255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
