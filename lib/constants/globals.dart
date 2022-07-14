import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    "ui designer",
    "developer"
  ];
}
