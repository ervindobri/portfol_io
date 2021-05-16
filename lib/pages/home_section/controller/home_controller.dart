import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin{


  late final AnimationController topController = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  )..forward();
  late final AnimationController bgController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late final Animation<double> titleAnimation = CurvedAnimation(
    parent: topController,
    curve: Curves.easeIn,
  );

  late List<Animation<double>> buttonAnimations;
  late List<AnimationController> buttonAnimationControllers;

  int _animDelay = 150;

  late List<Animation<double>> delayedAnimations;




  @override
  void onInit() {
      buttonAnimationControllers = [
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        ),
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        ),
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        ),
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        )
      ];
      buttonAnimations = [];
      delayedAnimations = [];
      for(var i in range(0, buttonAnimationControllers.length)){
        buttonAnimations.add(CurvedAnimation(
          parent: buttonAnimationControllers[i.toInt()],
          curve: Curves.easeInOut,
        ));
        delayedAnimations.add(Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: bgController,
                curve: Interval(.01, 1.0, curve: Curves.easeInOut)
            ))
        );
      }
      buttonAnimationControllers.forEach((element) {element.forward();});
    super.onInit();
  }

  void forwardAnimations() {
    topController.forward();
    bgController.forward();
    buttonAnimationControllers.forEach((element) { element.forward(); });
  }

  void reverseAnimations() {
    topController.reverse();
    bgController.reverse();
    buttonAnimationControllers.forEach((element) { element.reverse(); });
  }
}