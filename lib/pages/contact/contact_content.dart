import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/pages/contact/responsive_screens/contact.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType ==
                DeviceScreenType.desktop) {
              return const ContactDesktop();
            }
            if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
              return const ContactDesktop();
            }
            return const ContactMobile();
          },
        ),
        Positioned(
          bottom: 12,
          child: Row(
            children: [
              Text(
                "Developed with ",
                style: context.bodyText1
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.w100),
              ),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse("https://flutter.dev"));
                },
                child: Text(
                  "Flutter 💙",
                  style: context.bodyText1
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
