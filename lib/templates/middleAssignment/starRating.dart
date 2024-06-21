import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int initialRating;
  final void Function(int) onRatingChanged;

  StarRating({required this.initialRating, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _currentRating;

  _StarRatingState() : _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  Widget _buildStar(int index) {
    Icon icon;
    if (index < _currentRating) {
      icon = Icon(Icons.star, color: Colors.yellow);
    } else {
      icon = Icon(Icons.star_border, color: Colors.grey);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentRating = index + 1;
        });
        widget.onRatingChanged(_currentRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
