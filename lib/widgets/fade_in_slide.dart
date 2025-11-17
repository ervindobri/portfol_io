import 'package:flutter/cupertino.dart';

class FadingSlideWidget extends StatefulWidget {
  // final Animation<double> animation;
  final Offset offset;
  final bool noFade;
  final Widget child;
  final int durationMilliseconds;

  const FadingSlideWidget(
      {super.key,
      // required this.animation,
      required this.child,
      this.noFade = false,
      this.durationMilliseconds = 600,
      this.offset = Offset.zero});

  @override
  State<FadingSlideWidget> createState() => _FadingSlideWidgetState();
}

class _FadingSlideWidgetState extends State<FadingSlideWidget>
    with TickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      duration: Duration(milliseconds: widget.durationMilliseconds),
      vsync: this,
    );
    animation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.noFade) {
      return SlideTransition(
          position: Tween<Offset>(
            begin: widget.offset,
            end: Offset.zero,
          ).animate(animation),
          child: widget.child);
    }
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
            position: Tween<Offset>(
              begin: widget.offset,
              end: Offset.zero,
            ).animate(animation),
            child: widget.child));
  }
}
