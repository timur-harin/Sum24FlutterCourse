import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int tapped = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(widget.title),
      actions: <Widget>[
        Switch.adaptive(
          value: themeProvider.isDarkMode(context),
          onChanged: (value) {
            setState(() {
              tapped += 1;
            });
            if (tapped == 69) {
              tapped = 0;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('nice.'),
                ),
              );
            }
            themeProvider.toggleTheme(value);
          },
        ),
      ],
    );
  }
}
