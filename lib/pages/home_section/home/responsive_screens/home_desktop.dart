import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/custom_widgets/fade_in_slide.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/manager/menu_manager.dart';

class HomeDesktop extends StatefulWidget {
  HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    return Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 24,
              child: Container(
                height: imageSize / 2,
                width: imageSize / 2,
                decoration: BoxDecoration(
                  // color: ThemeUtils.green.withOpacity(.4),
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/blob2.png",
                      ),
                      opacity: .4),
                  color: Colors.white,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              left: width / 3,
              child: Container(
                height: imageSize / 2,
                width: imageSize / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/blob3.png",
                    ),
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 48,
              top: 48,
              child: Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  // color: ThemeUtils.green.withOpacity(.4),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/blob1.png",
                    ),
                    opacity: .4,
                  ),
                  // color: Colors.red,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 96, sigmaY: 96),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                    width: width / 2,
                    height: height,
                    color: GlobalColors.lightGrey.withOpacity(.4),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...Globals.skills
                            .map(
                              (e) => Text(
                                e.toUpperCase(),
                                style: context.headline1!.copyWith(
                                  // color: Colors.transparent,
                                  fontSize: 100,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color =
                                        GlobalColors.green.withOpacity(.3),
                                ),
                              ),
                            )
                            .toList(),
                        SizedBox(
                          height: 48,
                        ),
                        Row(
                          children: [
                            Text(
                              "Tech Stack",
                              style: context.bodyText1?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: <Color>[
                                      GlobalColors.primaryColor,
                                      GlobalColors.lightGrey
                                      //add more color here.
                                    ],
                                  ).createShader(
                                    Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                  ),
                              ),
                            ),
                            Icon(FontAwesomeIcons.angleDoubleRight,
                                color: GlobalColors.lightGrey)
                          ],
                        )
                      ],
                    )),
                Container(
                  width: width / 2,
                  height: height,
                  padding: const EdgeInsets.fromLTRB(48, 128 + 60, 48, 48),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FadingSlideWidget(
                          offset: Offset(0, 0.5),
                          child: Text(
                            Globals.title,
                            textAlign: TextAlign.right,
                            style: context.headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        FadingSlideWidget(
                          offset: Offset(0, 0.5),
                          child: Text(
                            Globals.subtitle,
                            textAlign: TextAlign.right,
                            style: context.headline6!
                                .copyWith(color: GlobalColors.lightGrey),
                          ),
                        ),
                        SizedBox(height: 96),
                        FadingSlideWidget(
                          offset: Offset(0, 0.5),
                          child: TextButton(
                              onPressed: () {},
                              child: Container(
                                  color: Colors.white,
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                  child: Text(
                                    Globals.letsWorkTogether,
                                    style: context.headline6!.copyWith(
                                        color: GlobalColors.primaryColor),
                                  ))),
                        ),
                      ]),
                ),
              ],
            ),
            Positioned(
              top: 128,
              child: Container(
                width: 256,
                height: 256,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Image.asset("assets/avatar.png",
                              width: imageSize, height: imageSize)),
                    ),
                    Positioned(
                        child: Image.asset("assets/avatar.png",
                            width: imageSize, height: imageSize)),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 48,
                left: width / 2 + 42,
                child: TextButton(
                  style: ButtonStyle(),
                  onPressed: () => uiMenuManager.updateMenuCommand.execute(1),
                  child: Container(
                      color: GlobalColors.lightGrey.withOpacity(.12),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Icon(FontAwesomeIcons.chevronDown,
                            color: Colors.white),
                      )),
                )),
          ],
        ));
  }
}
