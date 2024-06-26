import 'package:education/templates/lab6/card.dart';
import 'package:education/templates/lab6/notifier.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(onPressed: (){
         Provider.of<LocaleNotifier>(context, listen: false)
                    .switchLocale(); // Or toggle based on currentLocale
          
          }, icon: Icon(Icons.language)),
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
            Text("52", style: TextStyle(fontSize: 52*5.2,color: Color(0xFFFEF7FF) )),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.username, 
                // labelText: get from localization
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                 labelText: AppLocalizations.of(context)!.password, 
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
                child: Text( AppLocalizations.of(context)!.login,
                ),
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
