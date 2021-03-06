import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMeCard extends StatelessWidget {
  const ContactMeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    Globals.easyDoesIt,
                    textAlign: TextAlign.right,
                    style: context.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 56),
              TextButton(
                onPressed: () {
                  //TODO: open contact dialog animated
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: Text(
                    Globals.bigWhiteButton,
                    style: context.headline6!
                        .copyWith(color: GlobalColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "You can find me on social media too",
                style: context.bodyText1
                    ?.copyWith(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 16,
                children: Globals.socialMediaBubbles
                    .map(
                      (e) => Tooltip(
                        message: e.label,
                        textStyle: context.bodyText1,
                        decoration: BoxDecoration(color: Colors.transparent),
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
                            color: GlobalColors.primaryColor,
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
}

class MobileContactMeCard extends StatelessWidget {
  const MobileContactMeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final containerHeight = height * .3;
    return SizedBox(
      height: containerHeight,
      width: width * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Globals.wantToWorkWithMe,
                    maxLines: 2,
                    style: context.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
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
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  //TODO: open contact dialog animated
                },
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Text(
                    Globals.bigWhiteButton,
                    style: context.bodyText1!.copyWith(
                      color: GlobalColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 16,
            children: Globals.socialMediaBubbles
                .map(
                  (e) => Tooltip(
                    message: e.label,
                    textStyle: context.bodyText1,
                    decoration: BoxDecoration(color: Colors.transparent),
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
                        color: GlobalColors.primaryColor,
                        child: Center(
                          child: FaIcon(e.icon, size: 16),
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
}
