import 'package:flutter/cupertino.dart';

class FadingSlideWidget extends StatelessWidget {
  final Animation<double> animation;
  final Offset offset;
  final Widget child;

  const FadingSlideWidget(
      {Key? key,
      required this.animation,
      required this.child,
      this.offset = Offset.zero})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
            position: Tween<Offset>(
              begin: offset,
              end: Offset.zero,
            ).animate(animation),
            child: child));
  }
}
