import 'package:education/templates/lab6/card.dart';
import 'package:education/templates/lab6/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



final emailController = TextEditingController();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
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
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context).username
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context).password
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) {return Dialog(
                    child: ProfileCard(
                      imageUrl: 'https://sun9-72.userapi.com/impf/c638220/v638220224/1f00f/-QQD7cDESJA.jpg?size=999x733&quality=96&sign=8a771962b08d7019fcc40eeb29ac430e&c_uniq_tag=-YwPY4s_VKq0VtkZKfBb91YKz4mmmFb4sSna7pBIJfk&type=album',
                      name: 'John Doe',
                      description: 'description',
                    ),
                  );});

                },
                // TODO: Add localization
                child: Text(AppLocalizations.of(context).login),
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
