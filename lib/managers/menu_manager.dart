import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiMenuManager {
  ValueNotifier<int> menuIndex = ValueNotifier(0);
  ValueNotifier<List<GlobalKey>> itemKeys = ValueNotifier([]);

  ValueNotifier<bool> playContactAnimation = ValueNotifier(false);

  late ScrollController scrollController;

  final menuItemsCount = 3;
  late List<double> offsets;

  // To add a bit of delay in scrolling/animating
  Timer? _debounce;
  final _debounceDuration = const Duration(milliseconds: 50);

  double get offset => scrollController.offset;

  UiMenuManager() {
    scrollController = ScrollController();
    offsets = [];

    itemKeys.value = List.generate(menuItemsCount, (index) => GlobalKey());

    // General listener to update menu index & UI
    scrollController.addListener(() async {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(_debounceDuration, () async {
        // do something with query
        final index = getCurrentIndex();
        menuIndex.value = index;
      });
    });

    scrollController.addListener(() {
      final offset = scrollController.offset;
      if (offset > offsets[1] + 323) {
        playContactAnimation.value = true;
      } else {
        playContactAnimation.value = false;
      }
    });
  }

  setOffsets() {
    if (scrollController.hasClients) {
      final contentSize = scrollController.position.viewportDimension +
          scrollController.position.maxScrollExtent;
      // Store the scroll offsets
      offsets = List.generate(
          menuItemsCount, (index) => contentSize * index / menuItemsCount);

      if (kDebugMode) {
        print("Offsets: $offsets");
      }
    }
  }

  int getCurrentIndex() {
    final offset = scrollController.offset;
    // print(offset);
    var greater = offsets.where((e) => e >= offset - (646)).toList()
      ..sort(); //List of the greater values
    final item = greater.first;
    final index = offsets.indexOf(item);
    return index;
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
