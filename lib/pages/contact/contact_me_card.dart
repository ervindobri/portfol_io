import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeCard extends ConsumerWidget {
  const ContactMeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.bulbLine,
                  colorFilter: ColorFilter.mode(
                      context.theme.inverseTextColor, BlendMode.srcIn),
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  Globals.wantToWorkWithMe,
                  maxLines: 2,
                  textAlign: TextAlign.right,
                  style: context.headline5!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              Globals.easyDoesIt,
              textAlign: TextAlign.right,
              style: context.bodyText2!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextButton(
          style: GlobalStyles.primaryButtonStyle(theme),
          onPressed: () async {
            await EmailHelper.contactMe();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Globals.bigWhiteButton,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.textColor),
                ),
                const SizedBox(width: 24),
                SvgPicture.asset(
                  AppIcons.coffee,
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    theme.textColor,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showContactDialog(context) async {
    await EmailHelper.contactMe();
  }
}

class MobileContactMeCard extends StatelessWidget {
  const MobileContactMeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: context.theme.containerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Text(
                Globals.wantToWorkWithMe,
                maxLines: 2,
                style: context.bodyText2?.copyWith(
                  fontSize: 20,
                ),
              ),
              Material(
                color: context.theme.primaryColor,
                borderRadius: BorderRadius.circular(24),
                child: InkWell(
                  onTap: () => showContactDialog(context),
                  splashFactory: NoSplash.splashFactory,
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Globals.bigWhiteButton,
                          style: context.bodyText1,
                        ),
                        const FaIcon(FontAwesomeIcons.message, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 16,
            children: Globals.socialMediaBubbles
                .map(
                  (e) => Tooltip(
                    message: e.label,
                    textStyle: context.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: InkWell(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(e.url));
                          } catch (e) {
                            toast('Failed to launch ${e.toString()}');
                          }
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          color: context.theme.extBackgroundColor,
                          child: Center(
                            child: FaIcon(e.icon, size: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<void> showContactDialog(BuildContext context) async {
    await EmailHelper.contactMe();
  }
}
