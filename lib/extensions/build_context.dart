import 'package:flutter/material.dart';
import 'package:portfol_io/widgets/device_orientation.dart';

extension BuildContextExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  Orientation get orientation => OrientationProvider.of(this)!.orientation;
}
