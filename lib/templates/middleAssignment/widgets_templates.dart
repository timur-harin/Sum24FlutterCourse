import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A class containing static methods to build common UI templates.
class Templates {
  /// Builds a customizable button widget.
  ///
  /// @param context The build context.
  /// @param ref The widget reference.
  /// @param onPressed The callback function for button press.
  /// @param width The width of the button.
  /// @param height The height of the button.
  /// @param text The text to display on the button.
  /// @param radius The border radius of the button.
  /// @param color The background color of the button.
  /// @return The constructed button widget.
  static Widget buildButton({
    required BuildContext context,
    required WidgetRef ref,
    required void Function() onPressed,
    required double width,
    required double height,
    required Text text,
    double radius = 10,
    Color color = Colors.blue,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: Center(
        child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            fixedSize: Size(width, height),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: text,
        ),
      ),
    );
  }

  /// Builds a slider widget with customizable parameters.
  ///
  /// @param context The build context.
  /// @param title The title of the slider.
  /// @param param The current value of the slider.
  /// @param min The minimum value of the slider.
  /// @param max The maximum value of the slider.
  /// @param onChanged The callback function for value change.
  /// @param bottomPadding The bottom padding of the slider widget.
  /// @return The constructed slider widget.
  static Widget buildSlider({
    required BuildContext context,
    required String title,
    required double param,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    double bottomPadding = 20,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w900,
              fontSize: 18),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              min.toString(),
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
            Expanded(
              child: SizedBox(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 14,
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                    ),
                    child: Slider(
                      value: param,
                      min: min,
                      max: max,
                      divisions: (max - min).toInt(),
                      label: param.round().toString(),
                      onChanged: onChanged,
                      inactiveColor: Colors.blue.withOpacity(0.2),
                      activeColor: Colors.blue,
                    ),
                  )),
            ),
            Text(
              max.toString(),
              style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  /// Builds a content dialog widget with customizable children.
  ///
  /// @param ref The widget reference.
  /// @param children The list of child widgets to display in the dialog.
  /// @return The constructed content dialog widget.
  static Widget buildDialogContent({
    required WidgetRef ref,
    required List<Widget> children,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
