import 'package:flutter/widgets.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UiMenuManager {
  late Command<int, int> updateMenuCommand;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionListener = ItemPositionsListener.create();

  UiMenuManager() {
    updateMenuCommand = Command.createSync<int, int>((counter) => counter, 0);

    updateMenuCommand.listen((index, _) {
      itemScrollController.scrollTo(
          index: index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic);
    });

    itemPositionListener.itemPositions
        .debounce(const Duration(milliseconds: 50))
        .addListener(() {
      updateMenuCommand
          .execute(itemPositionListener.itemPositions.value.first.index);
    });
  }
}
