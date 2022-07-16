import 'package:flutter/widgets.dart';
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
}

List<ShowcaseItem> items = [];

class UiShowcaseManager {
  final itemsCommand = Command.createSync((x) => items, items);
  
  PageController viewController = PageController();

  double? get currentPage => viewController.page;

}
