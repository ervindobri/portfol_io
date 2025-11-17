// Create an inherited widget to provide orientation data
import 'package:flutter/material.dart';

class OrientationProvider extends InheritedWidget {
  final Orientation orientation;

  const OrientationProvider({
    super.key,
    required this.orientation,
    required super.child,
  });

  // Helper method to access the OrientationProvider from the widget tree
  static OrientationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrientationProvider>();
  }

  @override
  bool updateShouldNotify(OrientationProvider oldWidget) {
    return orientation != oldWidget.orientation;
  }
}