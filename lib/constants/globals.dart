import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/models/social_media_button.dart';
import 'package:portfol_io/models/tech_item.dart';

class Globals {
  static const List<String> menu = ["Home", "Work", "Contact Me"];

  static const String myEmail = "ervindobri@gmail.com";
  static const String myPhone = "+40 754 365 846";
  static const String contactMe = "Contact Me";
  static const String checkMeOut = "Check Me out";

  static String title = "Refining The Future.";
  static String subtitle = "Since '98";

  static const String githubUrl = "https://github.com/ervindobri";
  static const String facebookPage = "https://www.facebook.com/ervindobri/";

  static List<SocialMediaItem> socialMediaBubbles = [
    SocialMediaItem(
        label: "LinkedIn",
        icon: FontAwesomeIcons.linkedin,
        url: "https://www.linkedin.com/in/ervin-dobri-2b8494217/"),
    SocialMediaItem(
        label: "Facebook",
        icon: FontAwesomeIcons.facebook,
        url: "https://www.facebook.com/ervindobri/"),
    SocialMediaItem(
        label: "Instagram",
        icon: FontAwesomeIcons.instagram,
        url: "https://www.instagram.com/w1nt_r"),
    SocialMediaItem(
        label: "Dribbble",
        icon: FontAwesomeIcons.dribbble,
        url: "https://www.dribbble.com/w1nt_r"),
    SocialMediaItem(
        label: "Behance",
        icon: FontAwesomeIcons.behance,
        url: "https://www.behance.net/w1nt_r"),
  ];

  static String letsWorkTogether = "Let's work together.";

  static const skills = <String>[
    "flutter",
    "python",
    "developer",
    "dotnet",
    "ui/ux designer",
    "figma",
    "pyqt",
    "prototyping",
    "adobe xd",
    "mobile",
    "dart",
  ];

  static const techStack = <TechItem>[
    TechItem(
        name: "Flutter", asset: "flutter", link: "https://www.flutter.dev/"),
    TechItem(name: "Python", asset: "python", link: "https://www.python.org/"),
    TechItem(
        name: "C#",
        asset: "csharp",
        link: "https://docs.microsoft.com/en-us/dotnet/csharp/"),
    TechItem(name: "Figma", asset: "figma", link: "https://wwww.figma.com/"),
    TechItem(
        name: "Azure DevOps",
        asset: "devops",
        link: "https://azure.microsoft.com/en-us/services/devops/"),
  ];

  static const String showcase = "Showcase";
  static const String checkItOut = "Check it out";
  static const String clickToExpand = "Click to expand";

  static const String wantToWorkWithMe = "Want to work with me?";
  static const String easyDoesIt =
      "It’s as easy as pressing this big white button";

  static const String bigWhiteButton = "Big white button";

  static const String details = "Details";

  static const String inspiration =
      "Solving big problems is all about thinking small.";

  // static const String myLocation = "Targu Mures, Romania";
  static const String myLocation = "Budapest, Hungary";
  static const String myUniversity = "Sapientia EMTE, Targu Mures";

  static const String themeLabel = "THEME";

  static String hireMe = "Hire me";

  static const List<String> highlightList = [
    "10+ projects",
    "user-centric design",
    "accessibility",
    "user experience",
    "professional design"
  ];
}
