import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class UiMenuManager {
  late Command<int, int> updateMenuCommand;

  ValueNotifier<int> menuIndex = ValueNotifier(0);
  ValueNotifier<bool> playContactAnimation = ValueNotifier(false);

  late ScrollController scrollController;

  final menuItemsCount = 3;
  late List<double> offsets;

  // To add a bit of delay in scrolling/animating
  Timer? _debounce;
  final _debounceDuration = const Duration(milliseconds: 50);

  UiMenuManager() {
    scrollController = ScrollController();
    offsets = [];

    updateMenuCommand = Command.createSync<int, int>((counter) => counter, 0);

    updateMenuCommand
        .debounce(const Duration(milliseconds: 10))
        .listen((index, _) {
      menuIndex.value = index;
      final offset = offsets[index];
      scrollController.animateTo(offset,
          duration: kThemeAnimationDuration, curve: Curves.easeIn);
    });

    // General listener to update menu index & UI
    scrollController.addListener(() async {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(_debounceDuration, () async {
        // do something with query
        final offset = scrollController.offset;
        var greater = offsets.where((e) => e >= offset).toList()
          ..sort(); //List of the greater values
        final item = greater.first;
        final index = offsets.indexOf(item);
        menuIndex.value = index;
      });
    });

    menuIndex.addListener(() {
      if (menuIndex.value == offsets.indexOf(offsets.last)) {
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
    }
  }
}
