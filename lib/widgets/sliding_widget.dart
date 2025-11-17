import 'package:flutter/cupertino.dart';

class SlidingWidget extends StatelessWidget {
  final Animation<double> animation;
  final Offset offset;
  final Widget child;

  const SlidingWidget(
      {super.key,
        required this.animation,
        required this.child,
        this.offset = Offset.zero});
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }
}
