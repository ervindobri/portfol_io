import 'package:flutter/cupertino.dart';

class FadingSlideWidget extends StatefulWidget {
  // final Animation<double> animation;
  final Offset offset;
  final Widget child;

  const FadingSlideWidget(
      {Key? key,
      // required this.animation,
      required this.child,
      this.offset = Offset.zero})
      : super(key: key);

  @override
  State<FadingSlideWidget> createState() => _FadingSlideWidgetState();
}

class _FadingSlideWidgetState extends State<FadingSlideWidget>
    with TickerProviderStateMixin {
  late final AnimationController animation = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  @override
  void initState() {
    animation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
