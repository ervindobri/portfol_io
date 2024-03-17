import 'package:flutter/material.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/pages/contact/responsive_screens/contact.dart';
import 'package:portfol_io/widgets/device_orientation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrientationBuilder(builder: (context, orientation) {
          return ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType ==
                      DeviceScreenType.desktop ||
                  sizingInformation.deviceScreenType ==
                      DeviceScreenType.tablet) {
                return OrientationLayoutBuilder(
                  portrait: (context) => const OrientationProvider(
                    orientation: Orientation.portrait,
                    child: ContactDesktop(),
                  ),
                  landscape: (context) => OrientationProvider(
                    orientation: sizingInformation.deviceScreenType ==
                            DeviceScreenType.desktop
                        ? Orientation.portrait
                        : Orientation.landscape,
                    child: const ContactDesktop(),
                  ),
                );
              }
              return const ContactMobile();
            },
          );
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        )
      ],
    );
  }
}
