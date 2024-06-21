import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorNotifier extends Notifier<Color> {
  @override
  Color build() {
    return Colors.white;
  }

  void setColor(Color color) {
    state = color;
  }
}


final colorNotifierProvider = NotifierProvider<ColorNotifier, Color>((){
  return ColorNotifier();
});