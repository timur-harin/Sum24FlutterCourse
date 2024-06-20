import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_screen.dart';

/// A widget for displaying a star rating and updating the rating state.
class StarRatingWidget extends StatefulWidget {
  final WidgetRef ref;

  /// Constructor for StarRatingWidget.
  ///
  /// @param ref The widget reference.
  const StarRatingWidget({super.key, required this.ref});

  @override
  StarRatingWidgetState createState() => StarRatingWidgetState();
}

/// State class for managing the star rating widget.
class StarRatingWidgetState extends State<StarRatingWidget> {
  int _rating = 0;

  /// Updates the rating value and notifies the state provider.
  ///
  /// @param newRating The new rating value.
  void _updateRating(int newRating) {
    setState(() {
      _rating = newRating;
    });
    widget.ref.read(ratingProvider.notifier).state = newRating;
  }

  /// Builds a single star icon button.
  ///
  /// @param starNumber The number of the star.
  /// @return The constructed star icon button.
  Widget _buildStar(int starNumber) {
    return IconButton(
      icon: Icon(
        starNumber <= _rating ? Icons.star_rounded : Icons.star_border_rounded,
        color: Colors.amber,
        size: 34,
      ),
      onPressed: () {
        _updateRating(starNumber);
      },
      padding: const EdgeInsets.symmetric(horizontal: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildStar(1),
        _buildStar(2),
        _buildStar(3),
        _buildStar(4),
        _buildStar(5),
      ],
    );
  }
}

