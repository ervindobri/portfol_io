import 'package:flutter/material.dart';
import 'package:portfol_io/widgets/device_orientation.dart';

extension BuildContextExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  Orientation get orientation => OrientationProvider.of(this)!.orientation;
}


extension PaddingExtension on BuildContext {
  get topPadding => MediaQuery.of(this).padding.top;
  get bottomPadding => MediaQuery.of(this).padding.bottom;
  get leftPadding => MediaQuery.of(this).padding.left;
  get rightPadding => MediaQuery.of(this).padding.right;
}
