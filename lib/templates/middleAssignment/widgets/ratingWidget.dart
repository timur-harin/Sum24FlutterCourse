import 'package:education/templates/middleAssignment/providers/ratingProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingDialog extends ConsumerStatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends ConsumerState<RatingDialog> {
  int _rating= 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rate Your Experience'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('How would you rate your experience?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  _rating >= index + 1
                      ? Icons.star
                      : Icons.star_border,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            ref.read(ratingNotifierProvider.notifier).setRating('');
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed:  _rating != null
              ? () {
                  ref.read(ratingNotifierProvider.notifier).setRating(_rating.toString());
                  // Handle rating submission
                  Navigator.pop(context);
                }
              : () {
                ref.read(ratingNotifierProvider.notifier).setRating('');
                Navigator.pop(context);
              },
        ),
      ],
    );
  }
}