import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';

class ShowcaseItem {
  final String projectName;
  final String duration;
  final String description;
  final String url;

  final String imagesPath;
  final List<String> imageAssets;

  ShowcaseItem({
    this.projectName = "Project Name",
    this.duration = "3 months",
    this.description = "Lorem ipsum dolor sit amet, consectetur adipiscing...",
    this.url = "https://github.com/ervindobri/",
    this.imagesPath = "others", //must be under images/work directory
    this.imageAssets = const ['placeholder'],
  });

  @override
  String toString() {
    return 'ShowcaseItem(projectName: $projectName, duration: $duration)';
  }
}

//TODO: add items: showtime, penzmuzeum, ERP, HIMO
List<ShowcaseItem> showcaseItems = [
  ShowcaseItem(
      projectName: "Cheesify",
      duration: "Two weeks",
      url: "https://github.com/ervindobri/cheesify",
      imagesPath: 'cheesify',
      imageAssets: ['main', '1', '2', '3'],
      description:
          """This app concept was based on a cheese database application. You can browse various cheese types and find out interesting facts about them. UI Design in Adobe XD, app using flutter!"""),
  ShowcaseItem(
      projectName: "Adidas Originals Design",
      duration: "2 hours",
      url:
          "https://www.figma.com/file/zBqcTDzvy53cy9msnFSVNd/Adidas?node-id=0%3A1",
      imagesPath: 'adidas',
      imageAssets: [
        'main'
      ],
      description:
          """Buy adidas originals collections & single piece clothing. You can browse various cheese types and find out interesting facts about them. UI Design in Figma, app using flutter!"""),
  ShowcaseItem(
      projectName: "Various UI/UX Designs",
      duration: "-",
      url: "https://www.behance.net/w1nt_r/",
      imagesPath: 'others',
      imageAssets: ['sepsi', 'barber', 'payment'],
      description:
          """These images show various design projects I've completed over the last few months."""),
  ShowcaseItem(
    projectName: "Project#4",
  ),
  ShowcaseItem(
    projectName: "Project#5",
  ),
  ShowcaseItem(
    projectName: "Project#6",
  ),
  ShowcaseItem(
    projectName: "Project#7",
  ),
  ShowcaseItem(
    projectName: "Project#8",
  ),
];

enum View { single, grid, detail }

class UiShowcaseManager {
  late Command<void, List<ShowcaseItem>> itemsCommand;

  final currentItemCommand = Command.createSync<int, ShowcaseItem>(
      (x) => showcaseItems[x], showcaseItems.first);

  late Command<ShowcaseItem?, void> nextItemCommand;
  late Command<ShowcaseItem?, void> previousItemCommand;

  late Command<void, void> nextImageItemCommand;
  late Command<void, void> previousImageItemCommand;

  int initialPage = 0;
  int currentIndex = 0;

  ValueNotifier<int> currentImageIndex = ValueNotifier(0);
  ValueNotifier<int> maxItemNumber = ValueNotifier(6);
  ValueNotifier<bool> showImageOverlay = ValueNotifier(false);
  ValueNotifier<View> showcaseView = ValueNotifier(View.single);

  int get currentPage => currentIndex + 1;

  late Command<int, int?> setImageCommand;
  UiShowcaseManager() {
    itemsCommand =
        Command.createSyncNoParam<List<ShowcaseItem>>(selectShowcaseItems, []);
    nextItemCommand = Command.createSync<ShowcaseItem?, void>(nextItem, null);
    previousItemCommand =
        Command.createSync<ShowcaseItem?, void>(previousItem, null);

    showcaseView.addListener(() {
      print("execute");
      itemsCommand.execute();
    });

    nextImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxLength = currentItemCommand.value.imageAssets.length;
      if (maxLength > currentImageIndex.value + 1) {
        currentImageIndex.value++;
      } else {
        currentImageIndex.value = 0;
      }
    });
    previousImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxLength = currentItemCommand.value.imageAssets.length;
      if (currentImageIndex.value - 1 > -1) {
        currentImageIndex.value--;
      } else {
        currentImageIndex.value = maxLength - 1;
      }
    });

    currentItemCommand
        .debounce(const Duration(milliseconds: 300))
        .listen((item, _) {});

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
      final maxLength = currentItemCommand.value.imageAssets.length - 1;
      if (maxLength > currentImageIndex.value + 1) {
        currentImageIndex.value++;
      } else {
        currentImageIndex.value = 0;
      }
    });

    previousImageItemCommand
        .debounce(const Duration(milliseconds: 20))
        .listen((_, __) {
      final maxLength = currentItemCommand.value.imageAssets.length - 1;
      if (0 < currentImageIndex.value - 1) {
        currentImageIndex.value--;
      } else {
        currentImageIndex.value = maxLength - 1;
      }
    });

    setImageCommand = Command.createAsync((x) async {
      currentImageIndex.value = x;
      return null;
    }, 0);
  }

  List<ShowcaseItem> selectShowcaseItems() {
    print("selecting items..");
    return showcaseItems.take(maxItemNumber.value).toList();
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
}
