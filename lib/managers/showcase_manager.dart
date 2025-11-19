import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_command/flutter_command.dart';

class ShowcaseItem {
  final String projectName;
  final String duration;
  final String description;
  final String url;
  final String? publishedGooglePlayUrl;
  final String? publishedAppStoreUrl;

  final String imagesPath;
  final List<String> imageAssets;
  final List<String> tags;

  ShowcaseItem({
    this.projectName = "Project Name",
    this.duration = "3 months",
    this.description = "Lorem ipsum dolor sit amet, consectetur adipiscing...",
    this.url = "https://github.com/ervindobri/",
    this.publishedAppStoreUrl,
    this.publishedGooglePlayUrl,
    this.imagesPath = "others", //must be under images/work directory
    this.imageAssets = const ['placeholder'],
    this.tags = const [],
  });

  List<String> get images => List.generate(imageAssets.length,
      (index) => "assets/images/work/$imagesPath/${imageAssets[index]}");

  @override
  String toString() {
    return 'ShowcaseItem(projectName: $projectName, duration: $duration)';
  }

  factory ShowcaseItem.fromMap(Map<String, dynamic> e) {
    return ShowcaseItem(
      projectName: e['projectName'] ?? "",
      duration: e['duration'] ?? "",
      imagesPath: e['imagesPath'] ?? "",
      imageAssets: e['imageAssets'].cast<String>(),
      url: e['url'] ?? "https://github.com/ervindobri/",
      publishedAppStoreUrl: e['publishedAppStoreUrl'],
      publishedGooglePlayUrl: e['publishedGooglePlayUrl'],
      description: e['description'] ?? "",
      tags: e['tags'] != null ? e['tags'].cast<String>() : [],
    );
  }
}

enum LayoutView { single, grid, detail }

class UiShowcaseManager {
  late Command<void, List<ShowcaseItem>> itemsCommand;
  late Command<int, ShowcaseItem?> currentItemCommand;

  List<ShowcaseItem> showcaseItems = <ShowcaseItem>[];

  late Command<ShowcaseItem?, void> nextItemCommand;
  late Command<ShowcaseItem?, void> previousItemCommand;

  late Command<void, void> nextImageItemCommand;
  late Command<void, void> previousImageItemCommand;

  int initialPage = 0;
  int currentIndex = 0;

  ValueNotifier<int> currentImageIndex = ValueNotifier(0);
  ValueNotifier<int> maxItemNumber = ValueNotifier(6);
  ValueNotifier<bool> showImageOverlay = ValueNotifier(false);
  ValueNotifier<bool> showTutorialOverlay = ValueNotifier(false);
  ValueNotifier<LayoutView> showcaseView = ValueNotifier(LayoutView.single);

  late PageController carouselController;

  void onPreviousItem() => previousItemCommand.execute();
  void onNextItem() => nextItemCommand.execute();

  int get currentPage => currentIndex + 1;

  late Command<int, int?> setImageCommand;
  UiShowcaseManager() {
    carouselController = PageController();
    itemsCommand = Command.createAsync<void, List<ShowcaseItem>>(
        selectShowcaseItems,
        initialValue: []);
    currentItemCommand = Command.createSync(getCurrentItem, initialValue: null);

    nextItemCommand =
        Command.createSync<ShowcaseItem?, void>(nextItem, initialValue: null);
    previousItemCommand = Command.createSync<ShowcaseItem?, void>(previousItem,
        initialValue: null);

    showcaseView.addListener(() {
      itemsCommand.execute();
    });

    nextImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxIndex = currentItemCommand.value!.imageAssets.length - 1;
      if (maxIndex >= currentImageIndex.value + 1) {
        currentImageIndex.value++;
      } else {
        currentImageIndex.value = 0;
      }
    });
    previousImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxIndex = currentItemCommand.value!.imageAssets.length - 1;
      if (currentImageIndex.value > 0) {
        currentImageIndex.value--;
      } else {
        currentImageIndex.value = maxIndex;
      }
    });

    itemsCommand.debounce(const Duration(milliseconds: 300)).listen((item, _) {
      currentItemCommand.execute(0);
    });
    currentItemCommand
        .debounce(const Duration(milliseconds: 10))
        .listen((item, _) {
      currentImageIndex.value = 0;
    });

    previousItemCommand
        .debounce(const Duration(milliseconds: 100))
        .listen((item, _) {
      currentImageIndex.value = 0;
      currentItemCommand.execute(currentIndex);
    });

    nextItemCommand
        .debounce(const Duration(milliseconds: 100))
        .listen((item, _) {
      currentImageIndex.value = 0;
      currentItemCommand.execute(currentIndex);
    });

    nextImageItemCommand
        .debounce(const Duration(milliseconds: 20))
        .listen((_, __) {
      final maxLength = currentItemCommand.value!.imageAssets.length - 1;
      if (maxLength > currentImageIndex.value + 1) {
        currentImageIndex.value++;
      } else {
        currentImageIndex.value = 0;
      }
    });

    previousImageItemCommand
        .debounce(const Duration(milliseconds: 20))
        .listen((_, __) {
      final maxLength = currentItemCommand.value!.imageAssets.length - 1;
      if (0 < currentImageIndex.value - 1) {
        currentImageIndex.value--;
      } else {
        currentImageIndex.value = maxLength - 1;
      }
    });

    setImageCommand = Command.createAsync((x) async {
      currentImageIndex.value = x;
      return null;
    }, initialValue: 0);
  }

  List<ShowcaseItem> get otherItems => showcaseItems
      .where((element) => element != currentItemCommand.value)
      .toList();

  Future<List<ShowcaseItem>> selectShowcaseItems(void s) async {
    try {
      final source = await rootBundle.loadString('assets/files/items.json');
      final container = json.decode(source) as Iterable;

      showcaseItems = container.map((e) => ShowcaseItem.fromMap(e)).toList();
      return showcaseItems
          // .take(maxItemNumber.value)
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  void nextItem(item) async {
    if (currentIndex < showcaseItems.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
  }

  void previousItem(item) async {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = showcaseItems.length - 1;
    }
  }

  void showMoreItems() {
    maxItemNumber.value = maxItemNumber.value + 3;
    itemsCommand.execute();
  }

  ShowcaseItem getCurrentItem(int x) {
    if (x < showcaseItems.length) {
      return showcaseItems[x];
    }
    return ShowcaseItem();
  }

  void select(ShowcaseItem item) {
    final index = indexOf(item);
    currentItemCommand.execute(index);
  }

  int indexOf(ShowcaseItem item) {
    return showcaseItems.indexOf(item);
  }

  int previousItemIndex(ShowcaseItem item) {
    final currentIndex = indexOf(item);
    if (currentIndex == 0) return showcaseItems.length - 1;
    return currentIndex - 1;
  }

  int nextItemIndex(ShowcaseItem item) {
    final currentIndex = indexOf(item);
    if (currentIndex == showcaseItems.length - 1) return 0;
    return currentIndex + 1;
  }
}
