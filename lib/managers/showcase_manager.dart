import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_command/flutter_command.dart';

class ShowcaseItem {
  final String projectName;
  final String duration;
  final String description;
  final String url;

  final String imagesPath;
  final List<String> imageAssets;

  ShowcaseItem(
      {this.projectName = "Project Name",
      this.duration = "3 months",
      this.description =
          "Lorem ipsum dolor sit amet, consectetur adipiscing...",
      this.url = "https://github.com/ervindobri/",
      this.imagesPath = "images",
      this.imageAssets = const []});

  @override
  String toString() {
    return 'ShowcaseItem(projectName: $projectName, duration: $duration)';
  }
}

List<ShowcaseItem> items = [
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
];

class UiShowcaseManager {
  final itemsCommand = Command.createSync((x) => items, items);
  final currentItemCommand =
      Command.createSync<int, ShowcaseItem>((x) => items[x], items.first);

  late Command<ShowcaseItem?, void> nextItemCommand;
  late Command<ShowcaseItem?, void> previousItemCommand;

  int initialPage = 0;
  int currentIndex = 0;

  ValueNotifier<int> currentImageIndex = ValueNotifier(0);
  ValueNotifier<bool> showImageOverlay = ValueNotifier(false);

  int get currentPage => currentIndex + 1;

  late Command<int, int?> setImageCommand;
  UiShowcaseManager() {
    nextItemCommand = Command.createSync<ShowcaseItem?, void>(nextItem, null);
    previousItemCommand =
        Command.createSync<ShowcaseItem?, void>(previousItem, null);

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

    setImageCommand = Command.createAsync((x) async {
      currentImageIndex.value = x;
      return null;
    }, 0);
  }

  void nextItem(item) async {
    if (currentIndex < items.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
  }

  void previousItem(item) async {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = items.length - 1;
    }
  }
}
