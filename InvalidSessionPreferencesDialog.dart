import 'package:flutter/material.dart';

class InvalidSessionPreferencesDialog extends StatelessWidget {
  const InvalidSessionPreferencesDialog({super.key, required this.dialogText});
  final String dialogText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.33,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(dialogText),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              )
            ],
          ),
        )
    );
  }

}
