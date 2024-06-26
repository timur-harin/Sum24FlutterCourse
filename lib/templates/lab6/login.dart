import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  
=======

class LoginScreen extends StatelessWidget {
>>>>>>> upstream/main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
<<<<<<< HEAD
              AppLocalizations.of(context)!.title,
=======
    //  get from localization
     ""
>>>>>>> upstream/main
        ),
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
                label: Text(AppLocalizations.of(context)?.username ?? "Username"),
=======
>>>>>>> upstream/main
                // labelText: get from localization
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
<<<<<<< HEAD
                label: Text(AppLocalizations.of(context)?.password ?? "Password"),
=======
>>>>>>> upstream/main
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
<<<<<<< HEAD
                child: Text(AppLocalizations.of(context)?.login ?? "Login"),
=======
>>>>>>> upstream/main
                child: Text(""),
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
