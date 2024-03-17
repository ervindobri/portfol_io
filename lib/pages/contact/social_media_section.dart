import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/list.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            Globals.contactSocialTitle,
            style: context.bodyText1?.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: Globals.socialMediaBubbles
              .map(
                (e) => IconButton(
                  tooltip: e.label,
                  style: context.textButtonStyle,
                  hoverColor: context.theme.extBackgroundColor,
                  splashColor: Colors.black,
                  highlightColor: Colors.black,
                  onPressed: () async {
                    await launchUrlString(e.url);
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: FaIcon(
                        e.icon,
                        size: 16,
                        color: context.theme.inverseTextColor,
                      ),
                    ),
                  ),
                ),
              )
              .expandWithSeparator(
                  (e) => e,
                  const SizedBox(
                    width: 12,
                  ))
              .toList(),
        )
      ],
    );
  }
}
