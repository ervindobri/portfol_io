import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/models/social_media_button.dart';
import 'package:portfol_io/models/tech_item.dart';

class Globals {
  static const List<String> menu = ["Home", "Showcase", "Contact Me"];

  static const String myEmail = "ervindobri@gmail.com";
  static const String myPhone = "+40 754 365 846";
  static const String contactMe = "Contact Me";
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

  static final techStack = <TechItem>[
    const TechItem(
        name: "Flutter",
        asset: AppIcons.flutter,
        link: "https://www.flutter.dev/"),
    const TechItem(
        name: "Figma", asset: AppIcons.figma, link: "https://www.figma.com/"),
    const TechItem(
        name: "Python",
        asset: AppIcons.python,
        link: "https://www.python.org/"),
    // TechItem(
    //     name: "C#",
    //     asset: "csharp",
    //     link: "https://docs.microsoft.com/en-us/dotnet/csharp/"),
    // TechItem(
    //     name: "Azure DevOps",
    //     asset: "devops",
    //     link: "https://azure.microsoft.com/en-us/services/devops/"),
  ];

  static const String showcase = "Showcase";
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
    "Medior Flutter Developer",
    " UI/UX Designer",
    "Creative mind",
    "Team player"
  ];
  static const String myWorkplace = "Trendency Online";
  static const String myWorkplaceUrl = "https://trendency.hu/";
  static const String myLocation = "Budapest, Hungary";
  static const String myUniversity = "Sapientia EMTE, Targu Mures";
  static const String themeLabel = "THEME";
  static const String hireMe = "Hire me";
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
    "code",
    "inspire"
  ];

  static const double profileImageSizeBig = 700;
  static const double profileImageSizeSmall = 456;

  static const String contactTitle = "Contact me";
  static const String contactSocialTitle =
      "You can find me on social media too";
  static const String downloadResume = "Download resume";
  static const String resumeUrl = "assets/files/CV.pdf";

  static const String emailSubject = 'A new exciting opportunity';
  static const String emailBody = 'Dear Ervin,\n';
}
