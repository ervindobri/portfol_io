import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/models/tech_item.dart';

class Globals {
  static const List<String> menu = ["Home", "Work", "Contact Me"];

  static const String contactMe = "Contact Me";
  static const String checkMeOut = "Check Me out";

  static String title = "Refining The Future.";
  static String subtitle = "Since '98";

  static const String facebookPage =
      "https://www.facebook.com/izeneeszerusztokhej/";

  static Map<String, dynamic> socialMediaBubbles = {
    "Facebook": [FontAwesomeIcons.facebook, facebookPage],
    "Twitter": [FontAwesomeIcons.twitter, facebookPage],
    "Instagram": [FontAwesomeIcons.instagram, facebookPage],
  };

  static String letsWorkTogether = "Let's work together.";

  static const skills = <String>[
    "flutter",
    "python",
    "dotnet",
    "ui/ux designer",
    "developer"
  ];

  static const techStack = <TechItem>[
    TechItem(
        name: "Flutter", asset: "flutter", link: "https://dev.flutter.com/"),
    TechItem(name: "Python", asset: "python", link: "https://python.com/"),
    TechItem(name: "C#", asset: "csharp", link: "https://dev.flutter.com/"),
    TechItem(name: "Figma", asset: "figma", link: "https://dev.flutter.com/"),
    TechItem(name: "Azure DevOps", asset: "devops", link: "https://azure.com/"),
  ];

  static String showcase = "Showcase";
  static String checkItOut = "Check it out";
  static String clickToExpand = "Click to expand";
}
