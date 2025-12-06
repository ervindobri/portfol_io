import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/models/social_media_button.dart';
import 'package:portfol_io/models/tech_item.dart';

class Globals {
  static const List<String> menu = ["Home", "Showcase", "Contact Me"];

  static const String myEmail = "ervindobri@gmail.com";
  static const String myPhone = "+40 754 365 846";
  static const String contactMe = "Contact";
  static const String checkMeOut = "Check Me out";
  static const String title = "Refining The Future.";
  static const String subtitle = "Since '98";
  static const String githubUrl = "https://github.com/ervindobri";
  static const String facebookPage = "https://www.facebook.com/ervindobri/";

  static List<SocialMediaItem> socialMediaBubbles = [
    SocialMediaItem(
        label: "LinkedIn",
        icon: FontAwesomeIcons.linkedin,
        url: "https://www.linkedin.com/in/ervin-dobri/"),
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

  static final techStack = <TechItem>[
    const TechItem(
        name: "Flutter",
        asset: AppIcons.flutter,
        knowledgePercentage: 94,
        link: "https://www.flutter.dev/"),
    const TechItem(
        name: "Dart",
        asset: AppIcons.dart,
        knowledgePercentage: 91,
        link: "https://www.dart.dev/"),
    const TechItem(
        name: "Figma",
        knowledgePercentage: 89,
        asset: AppIcons.figma,
        link: "https://www.figma.com/"),
    const TechItem(
        name: "Firebase",
        knowledgePercentage: 91,
        asset: AppIcons.firebase,
        link: "https://firebase.google.com/"),
    const TechItem(
        name: "Python",
        knowledgePercentage: 87,
        asset: AppIcons.python,
        link: "https://www.python.org/"),
    const TechItem(
        name: "C#",
        asset: AppIcons.csharp,
        knowledgePercentage: 78,
        link: "https://docs.microsoft.com/en-us/dotnet/csharp/"),
    // TechItem(
    //     name: "Azure DevOps",
    //     asset: "devops",
    //     link: "https://azure.microsoft.com/en-us/services/devops/"),
  ];

  static const String showcase = "Showcase";
  static const String featuredProjects = "Featured projects";
  static const String checkItOut = "Check it out";
  static const String clickToExpand = "Click to expand";
  static const String wantToWorkWithMe = "Want to work with me?";
  static const String easyDoesIt =
      "Just send a quick hello, and let’s start working together.";

  static const String bigWhiteButton = "Send a message";
  static const String details = "Details";
  static const String inspiration =
      "Solving big problems is all about thinking small.";

  static const String myName = "Ervin Dobri";
  static const List<String> mySkills = [
    "Flutter Developer",
    "UI/UX Designer",
    "Creative Mind",
    "Team Player"
  ];
  static const String myWorkplace = "Trendency Online";
  static const String myWorkplaceUrl = "https://trendency.hu/";
  static const String myLocation = "Budapest, Hungary";
  static const String myUniversity = "Sapientia EMTE, Targu Mures";
  static const String themeLabel = "THEME";
  static const String hireMe = "Hire me";
  static const String letsWorkTogether = "Let's work together";
  static const List<String> highlightList = [
    "10+ projects",
    "user-centric design",
    "accessibility",
    "user experience",
    "professional design"
  ];

  static const double maxBoxWidth = 1282.0;

  static const String titleText1 = "Hi! I'm Ervin Dobri";
  static const String titleText2 = "Ervin Dobri:";
  static const String workTitle = "Featured projects";

  static const List<String> animatedSkills = [
    "design",
    "create",
    "implement",
    "code",
    "inspire",
    "admire"
  ];

  static const double profileImageSizeBig = 700;
  static const double profileImageSizeSmall = 456;

  static const String contactTitle = "Contact me";
  static const String contactSocialTitle =
      "You can find me on social media too";
  static const String downloadResume = "Download resume";
  static const String resumeUrl = "assets/files/myCV.pdf";

  static const String emailSubject = 'A new exciting opportunity';
  static const String emailBody = 'Dear Ervin,\n';

  static const String builtWithFlutter = "BUILT WITH FLUTTER 💙";

  static const String aboutMe = 'About me';
  static const String aboutMeDesc1 = 'Hi there! 👋🏻';
  static const String aboutMeDesc2 =
      """”I am a multilingual IT Engineer (Hungarian, English and Romanian speaking) professional with over 5 years of experience across development and product design. \nHaving experience in multiple sectors for the last 5 years, I’ve completed multiple projects both as a developer and as a UI/UX designer. 
\nMy current passions are design, gaming and football”""";
  static const String expertise = 'Expertise';

  static const ColorFilter greyscaleColorFilter = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}
