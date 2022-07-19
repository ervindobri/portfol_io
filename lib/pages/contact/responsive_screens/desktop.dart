import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/contact/parallax_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDesktop extends StatefulWidget {
  ContactDesktop({Key? key}) : super(key: key);

  @override
  State<ContactDesktop> createState() => _ContactDesktopState();
}

class _ContactDesktopState extends State<ContactDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    final containerHeight = height * .6;
    return ClipRRect(
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            color: Color(0xff292929),
            child: Wrap(
              spacing: width / 10,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ParallaxCard(),
                Expanded(
                  child: SizedBox(
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
                                padding:
                                    const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                child: Text(
                                  Globals.bigWhiteButton,
                                  style: context.headline6!.copyWith(
                                      color: GlobalColors.primaryColor),
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
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                      child: InkWell(
                                        onTap: () async {
                                          try {
                                            await launchUrl(Uri.parse(e.url));
                                          } catch (e) {
                                            //TODO: toast
                                          }
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
