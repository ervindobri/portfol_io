// import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiMenuManager {
  ValueNotifier<int> menuIndex = ValueNotifier(0);
  ValueNotifier<List<GlobalKey>> itemKeys = ValueNotifier([]);

  ValueNotifier<bool> playContactAnimation = ValueNotifier(false);

  late ScrollController scrollController;

  final menuItemsCount = 3;

  // To add a bit of delay in scrolling/animating
  // Timer? _debounce;
  // final _debounceDuration = const Duration(milliseconds: 50);

  double get offset => scrollController.offset;

  List<double> offsets = [0, 0, 0];

  bool animating = false;

  void setOffset(int index, double offset) {
    offsets[index] = offset;
  }

  UiMenuManager() {
    scrollController = ScrollController();

    itemKeys.value = List.generate(menuItemsCount, (index) => GlobalKey());

    // General listener to update menu index & UI
    scrollController.addListener(() async {
      if (animating) return;
      final index = getCurrentIndex(scrollController.offset);
      if (index == menuIndex.value) return;
      menuIndex.value = index;
    });
  }

  int getCurrentIndex(double offset) {
    if (kDebugMode) {
      print("find offset: $offset");
    }
    final currentIndex =
        offsets.indexOf(offsets.where((element) => element <= offset).last);

    if (kDebugMode) {
      print("scrolled to : $currentIndex");
    }
    return currentIndex;
  }

  void animateToPage(int index) {
    Scrollable.ensureVisible(
      itemKeys.value[index].currentContext!,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ).then((_) {
      setOffset(index, scrollController.offset);
      menuIndex.value = index;
      animating = false;
    });
  }

  void setPage(int index) {
    menuIndex.value = index;
    animating = true;
    animateToPage(index);
  }

  void setVisiblePage(int index) {
    menuIndex.value = index;
    animating = true;
  }
}
