import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/widgets/hover_button.dart';

enum StrokeConnerType { rounded, sharp }

/// child,
/// strokeWidth = 6,
/// strokeHeight = 100,
/// backgroundColor = Colors.black12,
/// thumbColor = Colors.white,
/// alignment = Alignment.topRight,
/// padding = EdgeInsets.zero,
/// strokeConnerType = StrokeConnerType.rounded,
/// showScrollbar = true,
/// scrollbarMargin = const EdgeInsets.all(8.0),

class BumbleScrollbar extends StatefulWidget {
  const BumbleScrollbar({
    super.key,
    this.strokeWidth = 6,
    this.strokeHeight = 100,
    this.thumbHeight = 33,
    this.backgroundColor = Colors.black12,
    this.thumbColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = EdgeInsets.zero,
    this.strokeConnerType = StrokeConnerType.rounded,
    this.showScrollbar = true,
    this.scrollbarMargin = const EdgeInsets.all(8.0),
    required this.controller,
  });

  const BumbleScrollbar.web({
    super.key,
    this.strokeWidth = 24,
    this.strokeHeight = 200,
    this.thumbHeight,
    this.backgroundColor = Colors.black12,
    this.thumbColor = Colors.white,
    this.alignment = Alignment.topRight,
    this.padding = EdgeInsets.zero,
    this.strokeConnerType = StrokeConnerType.rounded,
    this.showScrollbar = true,
    this.scrollbarMargin = const EdgeInsets.all(8.0),
    required this.controller,
  });

  final double strokeWidth;
  final double strokeHeight;
  final double? thumbHeight;
  final Color thumbColor;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry scrollbarMargin;
  final StrokeConnerType strokeConnerType;
  final bool showScrollbar;
  final ScrollController controller;

  @override
  BumbleScrollbarState createState() => BumbleScrollbarState();
}

class BumbleScrollbarState extends State<BumbleScrollbar> {
  late ScrollController _controller;
  late double _thumbHeight;
  late double _strokeHeight;

  double _thumbPosition = 0;

  late ValueNotifier<double> valueListener;

  @override
  void initState() {
    super.initState();
    // 33% of the scrollbar stroke height
    _thumbHeight = widget.thumbHeight != null
        ? max(
            widget.thumbHeight!,
            widget.strokeHeight * 0.25,
          )
        : widget.strokeHeight * 0.33;
    _strokeHeight = widget.strokeHeight;
    _controller = widget.controller..addListener(_scrollListener);
    valueListener = ValueNotifier(_thumbPosition);
  }

  void _scrollListener() {
    if (_controller.hasClients) {
      final double maxScrollSize = _controller.position.maxScrollExtent;
      final double currentPosition = _controller.position.pixels;
      final scrollPosition =
          ((_strokeHeight - _thumbHeight) / (maxScrollSize / currentPosition));

      setState(() {
        _thumbPosition = scrollPosition.clamp(0, _strokeHeight - _thumbHeight);
        valueListener.value = _thumbPosition;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.strokeWidth;

    final connerRadius = widget.strokeConnerType == StrokeConnerType.rounded
        ? BorderRadius.circular(width)
        : BorderRadius.zero;

    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.scrollbarMargin,
        child: HoverWidget(builder: (context, hovering) {
          return Stack(
            children: [
              Container(
                width: width,
                height: _strokeHeight,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: connerRadius,
                ),
              ),
              AnimatedBuilder(
                  animation: valueListener,
                  builder: (context, child) {
                    final yOffset = valueListener.value;
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.fastLinearToSlowEaseIn,
                      top: yOffset,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          final direction =
                              details.delta.dy; // 1 - down/ -1 - up
                          final maxVerticalPosition = (_strokeHeight -
                              _thumbHeight); // 200 - 33%*200 = 200-66 = 133

                          if (valueListener.value == maxVerticalPosition &&
                              direction > 0) return;

                          final step = _thumbHeight / 44;
                          final newValue =
                              (valueListener.value + (direction * step))
                                  .clamp(.0, maxVerticalPosition);
                          valueListener.value = newValue;

                          // Since the maxScrollExtent != scrollHeight we need to adjust
                          final maxScrollExtent =
                              _controller.position.maxScrollExtent;
                          final multiplier =
                              (valueListener.value / maxVerticalPosition);
                          final newScrollPosition =
                              maxScrollExtent * multiplier;

                          if (kDebugMode) {
                            print(
                                "$multiplier Scrolled to: $newScrollPosition / ${_controller.position.maxScrollExtent}");
                          }

                          // Go to new scroll position
                          _controller.jumpTo(newScrollPosition);
                        },
                        child: AnimatedContainer(
                          width: width,
                          duration: kThemeAnimationDuration,
                          height: _thumbHeight,
                          decoration: BoxDecoration(
                            color: hovering
                                ? widget.thumbColor
                                : widget.thumbColor.withOpacity(.4),
                            borderRadius: connerRadius,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          );
        }),
      ),
    );
  }
}
