import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('login')),
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
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context)!.translate('username'),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(height: 20),
            ),
            Expanded(
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context)!.translate('password'),
                ),
                obscureText: true,
              ),
            ),
            Expanded(
              child: SizedBox(height: 20),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print('Username: ${usernameController.text}');
                    print('Password: ${passwordController.text}');
                  },
                  child: Text(AppLocalizations.of(context)!.translate('login')),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.abc),
                  onPressed: () {
                    Locale currentLocale =
                        Provider.of<LocaleNotifier>(context, listen: false)
                            .currentLocale;
                    if (currentLocale.languageCode == 'ru') {
                      Provider.of<LocaleNotifier>(context, listen: false)
                          .switchLocale(Locale('en'));
                    } else {
                      Provider.of<LocaleNotifier>(context, listen: false)
                          .switchLocale(Locale('ru'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}