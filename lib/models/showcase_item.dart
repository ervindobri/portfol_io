class ShowcaseItem {
  final String projectName;
  final String duration;
  final String description;
  final String url;
  final String? publishedGooglePlayUrl;
  final String? publishedAppStoreUrl;

  final String imagesPath;
  final String? figmaLink;
  final List<String> imageAssets;
  final List<String> tags;
  final List<String> roles;

  ShowcaseItem({
    this.projectName = "Project Name",
    this.duration = "3 months",
    this.description = "Lorem ipsum dolor sit amet, consectetur adipiscing...",
    this.url = "https://github.com/ervindobri/",
    this.roles = const [],
    this.figmaLink,
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
      figmaLink: e['figmaLink'],
      imagesPath: e['imagesPath'] ?? "",
      roles: e['roles']?.cast<String>() ?? const <String>[],
      imageAssets: e['imageAssets'].cast<String>(),
      url: e['url'] ?? "https://github.com/ervindobri/",
      publishedAppStoreUrl: e['publishedAppStoreUrl'],
      publishedGooglePlayUrl: e['publishedGooglePlayUrl'],
      description: e['description'] ?? "",
      tags: e['tags'] != null ? e['tags'].cast<String>() : [],
    );
  }
}