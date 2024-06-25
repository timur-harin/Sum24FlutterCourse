import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:education/templates/lab6/localization.dart';

class LoginScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const LoginScreen({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('title'), 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              onLocaleChange(Locale(value));
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'en',
                  child: Text(localizations.translate('english')),
                ),
                PopupMenuItem<String>(
                  value: 'ru',
                  child: Text(localizations.translate('russian')),
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
                border: const OutlineInputBorder(),
                labelText: localizations.translate('username'), 
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localizations.translate('password'), 
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(
                ),
                child: Text(localizations.translate('login')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}