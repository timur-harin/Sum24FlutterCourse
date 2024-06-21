import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingNotifier extends Notifier<String> {
  @override
  String build() {
    return "No rating";
  }

  void setRating(String rating) {
    state = rating;
  }
}


final ratingNotifierProvider = NotifierProvider<RatingNotifier, String>((){
  return RatingNotifier();
});