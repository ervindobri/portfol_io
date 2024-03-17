import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final themeColor = ref.watch(themeColorProvider);
    return SizedBox(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.bulbLine,
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
            style: GlobalStyles.primaryButtonStyle(theme, themeColor),
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
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Globals.wantToWorkWithMe,
                    maxLines: 2,
                    style: context.headline6?.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    Globals.easyDoesIt,
                    style: context.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => showContactDialog(context),
                style: GlobalStyles.whiteTextButtonStyle(),
                child: Container(
                  width: width / 2,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Center(
                    child: Text(
                      Globals.bigWhiteButton,
                      style: context.bodyText1!.copyWith(
                        color: GlobalColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            children: Globals.socialMediaBubbles
                .map(
                  (e) => Tooltip(
                    message: e.label,
                    textStyle: context.bodyText1,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: InkWell(
                      onTap: () async {
                        try {
                          await launchUrl(Uri.parse(e.url));
                        } catch (e) {
                          //TODO: toast
                        }
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        color: GlobalColors.primaryColor,
                        child: Center(
                          child: FaIcon(e.icon, size: 24),
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
