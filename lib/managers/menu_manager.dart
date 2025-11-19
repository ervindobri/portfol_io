import 'dart:async';

import 'package:flutter/material.dart';

class UiMenuManager {
  ValueNotifier<int> menuIndex = ValueNotifier(0);
  ValueNotifier<List<GlobalKey>> itemKeys = ValueNotifier([]);

  ValueNotifier<bool> playContactAnimation = ValueNotifier(false);

  late ScrollController scrollController;

  final menuItemsCount = 3;

  // To add a bit of delay in scrolling/animating
  Timer? _debounce;
  final _debounceDuration = const Duration(milliseconds: 50);

  double get offset => scrollController.offset;

  UiMenuManager() {
    scrollController = ScrollController();

    itemKeys.value = List.generate(menuItemsCount, (index) => GlobalKey());

    // General listener to update menu index & UI
    scrollController.addListener(() async {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(_debounceDuration, () async {
        // do something with query
        // final index = getCurrentIndex();
        // menuIndex.value = index;
      });
    });

    // scrollController.addListener(() {
    //   final offset = scrollController.offset;
    //   if (offset > offsets[1] + 323) {
    //     playContactAnimation.value = true;
    //   } else {
    //     playContactAnimation.value = false;
    //   }
    // });
  }



  void animateToPage(int index) {
    Scrollable.ensureVisible(
      itemKeys.value[index].currentContext!,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void setPage(int index) {
    menuIndex.value = index;
    animateToPage(index);
  }
}
