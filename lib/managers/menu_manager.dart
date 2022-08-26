import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UiMenuManager {
  late Command<int, int> updateMenuCommand;
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionListener;

  ValueNotifier<int> menuIndex = ValueNotifier(0);
  ValueNotifier<bool> playContactAnimation = ValueNotifier(false);

  UiMenuManager() {
    itemScrollController = ItemScrollController();
    itemPositionListener = ItemPositionsListener.create();
    updateMenuCommand = Command.createSync<int, int>((counter) => counter, 0);

    updateMenuCommand
        .debounce(const Duration(milliseconds: 10))
        .listen((index, _) {
      menuIndex.value = index;
      itemScrollController.scrollTo(
        index: menuIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    });

    itemPositionListener.itemPositions
        .debounce(const Duration(milliseconds: 25))
        .addListener(() {
      final positions = itemPositionListener.itemPositions.value.length;
      final scrolledPosition =
          itemPositionListener.itemPositions.value.toList()[positions ~/ 2];
      if (scrolledPosition.itemLeadingEdge == 0) {
        menuIndex.value = scrolledPosition.index;
        // Note: simulate clicking on this menu item
        // to trigger changing the State of itemScrollController.
        // Otherwise you can't navigate back to the page you scrolled from.
        Future.delayed(const Duration(milliseconds: 300), () {
          updateMenuCommand.execute(scrolledPosition.index);
          // print("Scrolled to: ${scrolledPosition.index}");
        });
      }
      // print(itemPositionListener.itemPositions.value);
      // updateMenuCommand
      //     .execute(itemPositionListener.itemPositions.value.first.index);
    });

    itemPositionListener.itemPositions
        .debounce(const Duration(milliseconds: 10))
        .addListener(() {
      final list = itemPositionListener.itemPositions.value;
      //If the list was scrolled to the contact page
      if (list.isNotEmpty && list.last.index == 2) {
        //Trigger animation
        playContactAnimation.value = true;
      } else {
        playContactAnimation.value = false;
      }
    });

    menuIndex.addListener(() {
      // itemScrollController.scrollTo(
      //   index: menuIndex.value,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeInOutCubic,
      // );
    });
  }
}
