import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeCard extends ConsumerWidget {
  const ContactMeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final containerHeight = height * .6;
    return SizedBox(
      height: containerHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Globals.wantToWorkWithMe,
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    style: context.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
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
              const SizedBox(height: 56),
              TextButton(
                onPressed: () => showContactDialog(context),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: Text(
                    Globals.bigWhiteButton,
                    style: context.headline6!,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "You can find me on social media too",
                style: context.bodyText1?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                children: Globals.socialMediaBubbles
                    .map(
                      (e) => Tooltip(
                        message: e.label,
                        textStyle: context.bodyText1,
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: InkWell(
                          onTap: () async {
                            try {
                              await launchUrl(Uri.parse(e.url));
                            } catch (e) {
                              //TODO: toast
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            color: GlobalColors.lightGrey.withOpacity(.4),
                            child: Center(
                              child: FaIcon(e.icon, size: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
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
