import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
      actions: <Widget>[
        Switch.adaptive(
          value: themeProvider.isDarkMode(context),
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
