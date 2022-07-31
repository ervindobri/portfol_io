import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  factory ShowcaseItem.fromMap(Map<String, dynamic> e) {
    return ShowcaseItem(
      projectName: e['projectName'] ?? "",
      duration: e['duration'] ?? "",
      imagesPath: e['imagesPath'] ?? "",
      imageAssets: e['imageAssets'].cast<String>(),
      url: e['url'] ?? "https://github.com/ervindobri/",
      description: e['description'] ?? "",
    );
  }
}

//TODO: add items: showtime, penzmuzeum, ERP, HIMO
// List<ShowcaseItem> showcaseItems = [
//   ShowcaseItem(
//       projectName: "Cheesify",
//       duration: "Two weeks",
//       url: "https://github.com/ervindobri/cheesify",
//       imagesPath: 'cheesify',
//       imageAssets: ['main', '1', '2', '3'],
//       description:
//           """This app concept was based on a cheese database application. You can browse various cheese types and find out interesting facts about them. UI Design in Adobe XD, app using flutter!"""),
//   ShowcaseItem(
//       projectName: "Adidas Originals Design",
//       duration: "2 hours",
//       url:
//           "https://www.figma.com/file/zBqcTDzvy53cy9msnFSVNd/Adidas?node-id=0%3A1",
//       imagesPath: 'adidas',
//       imageAssets: [
//         'main'
//       ],
//       description:
//           """Buy adidas originals collections & single piece clothing. You can browse various cheese types and find out interesting facts about them. UI Design in Figma, app using flutter!"""),
//   ShowcaseItem(
//       projectName: "Barbr",
//       duration: "Few days",
//       imagesPath: 'barbr',
//       imageAssets: ['main', 'light', 'dark'],
//       description:
//           "This project was based on a wild idea: finding barbers with the help of a simple app. You can search & find lots of barbers which show up on the map as markers. You can make appointments and set recurring dates when you are free to have a haircut. Furthermore, the barbers have ratings so you know you'll always be in professional hands!"),
//   ShowcaseItem(
//     projectName: "bAllerz",
//     duration: "Few days",
//     imagesPath: 'ballerz',
//     imageAssets: ['main', '1', '2'],
//     description:
//         "When I was living in Budapest I had trouble finding people to play football with. Of course, there are social media groups where you can do so, but an actual phone app would make everything a lot smoother! Feature include creating a friendly match in a specific location, with a specific team size, so you'll only have people who are really interested. On the other hand, you can browse of many different events, or games which show up on the map!",
//   ),
//   ShowcaseItem(
//       projectName: "Various UI/UX Designs",
//       duration: "-",
//       url: "https://www.behance.net/w1nt_r/",
//       imagesPath: 'others',
//       imageAssets: ['sepsi', 'barber', 'payment'],
//       description:
//           """These images show various design projects I've completed over the last few months."""),
//   ShowcaseItem(
//     projectName: "Project#5",
//   ),
//   ShowcaseItem(
//     projectName: "Project#6",
//   ),
//   ShowcaseItem(
//     projectName: "Project#7",
//   ),
//   ShowcaseItem(
//     projectName: "Project#8",
//   ),
// ];

enum View { single, grid, detail }

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
  ValueNotifier<View> showcaseView = ValueNotifier(View.single);

  int get currentPage => currentIndex + 1;

  late Command<int, int?> setImageCommand;
  UiShowcaseManager() {
    itemsCommand =
        Command.createAsync<void, List<ShowcaseItem>>(selectShowcaseItems, []);
    currentItemCommand = Command.createSync(getCurrentItem, null);

    nextItemCommand = Command.createSync<ShowcaseItem?, void>(nextItem, null);
    previousItemCommand =
        Command.createSync<ShowcaseItem?, void>(previousItem, null);

    showcaseView.addListener(() {
      itemsCommand.execute();
    });

    nextImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxLength = currentItemCommand.value!.imageAssets.length;
      if (maxLength > currentImageIndex.value + 1) {
        currentImageIndex.value++;
      } else {
        currentImageIndex.value = 0;
      }
    });
    previousImageItemCommand = Command.createSyncNoParamNoResult(() {
      final maxLength = currentItemCommand.value!.imageAssets.length;
      if (currentImageIndex.value - 1 > -1) {
        currentImageIndex.value--;
      } else {
        currentImageIndex.value = maxLength - 1;
      }
    });

    itemsCommand.debounce(const Duration(milliseconds: 300)).listen((item, _) {
      currentItemCommand.execute(0);
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
    }, 0);
  }

  Future<List<ShowcaseItem>> selectShowcaseItems(void s) async {
    try {
      final source = await rootBundle.loadString('assets/files/items.json');
      final container = json.decode(source) as Iterable;

      showcaseItems = container.map((e) => ShowcaseItem.fromMap(e)).toList();
      return showcaseItems.take(maxItemNumber.value).toList();
    } catch (e) {
      print(e);
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
}
