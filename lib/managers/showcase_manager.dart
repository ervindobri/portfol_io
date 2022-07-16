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
      description:
          """This app concept was based on a cheese database application. You can browse various cheese types and find out interesting facts about them. UI Design in Figma, app using flutter!"""),
  ShowcaseItem(
      projectName: "Adidas Originals Design",
      duration: "2 hours",
      description:
          """This app concept was based on a cheese database application. You can browse various cheese types and find out interesting facts about them. UI Design in Figma, app using flutter!"""),
];

class UiShowcaseManager {
  final itemsCommand = Command.createSync((x) => items, items);
  final currentItemCommand =
      Command.createSync<int, ShowcaseItem>((x) => items[x], items.first);

  late Command<ShowcaseItem?, void> nextItemCommand;
  late Command<ShowcaseItem?, void> previousItemCommand;

  int initialPage = 0;
  int currentIndex = 0;

  int get currentPage => currentIndex + 1;

  UiShowcaseManager() {
    nextItemCommand = Command.createSync<ShowcaseItem?, void>(nextItem, null);
    previousItemCommand =
        Command.createSync<ShowcaseItem?, void>(previousItem, null);

    // currentItemCommand
    //     .debounce(const Duration(milliseconds: 300))
    //     .listen((item, _) {
    // });

    previousItemCommand
        .debounce(const Duration(milliseconds: 100))
        .listen((item, _) {
      currentItemCommand.execute(currentIndex);
    });

    nextItemCommand
        .debounce(const Duration(milliseconds: 100))
        .listen((item, _) {
      currentItemCommand.execute(currentIndex);
    });
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
