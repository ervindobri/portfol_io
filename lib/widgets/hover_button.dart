import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget Function(bool) builder;

  const HoverWidget({super.key, required this.builder});

  @override
  State<HoverWidget> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (hovering) {
          setState(() => isHovered = true);
        },
        onExit: (hovering) {
          setState(() => isHovered = false);
        },
        child: widget.builder(isHovered));
  }
}
