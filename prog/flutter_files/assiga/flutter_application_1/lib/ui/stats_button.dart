import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class Statistics extends StatelessWidget {
  String date;
  String type;
  Statistics({super.key, required this.date, required this.type});

  @override
  Widget build (BuildContext context) {
    return CupertinoButton(pressedOpacity: 0.65,
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.drop,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                '$type Session in $date',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
      onPressed: () {
        _showAlertDialog(context);
      },
      
    );
  }


}


void _showAlertDialog(BuildContext context) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Delete the session?'),
      content: const Text('No return back'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Leave'),
        ),
        CupertinoDialogAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as deletion, and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
