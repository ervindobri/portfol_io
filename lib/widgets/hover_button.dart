import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;
  final void Function(BuildContext, bool)? listener;

  const HoverWidget({super.key, required this.builder, this.listener});

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
        widget.listener?.call(context, true);
        },
        onExit: (hovering) {
          setState(() => isHovered = false);
        widget.listener?.call(context, false);
        },
      child: widget.builder(context, isHovered),
    );
  }
}
