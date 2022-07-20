import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart' as atkit;
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/styles.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMobile extends StatefulWidget {
  HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = width * .45;
    return ClipRRect(
      child: Container(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //BG Blobs
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
                right: 24,
                top: 48 + 42,
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
              //Content
              Column(
                children: [
                  Container(
                    width: width,
                    height: height / 2,
                    padding: const EdgeInsets.fromLTRB(24, 48 + 42, 24, 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FadingSlideWidget(
                            offset: Offset(0, 0.5),
                            child: SizedBox(
                              width: width * .6,
                              child: Text(
                                Globals.title,
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: context.headline6!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          FadingSlideWidget(
                            offset: Offset(0, 0.5),
                            child: Text(
                              Globals.subtitle,
                              textAlign: TextAlign.right,
                              style: context.bodyText2!
                                  .copyWith(color: GlobalColors.lightGrey),
                            ),
                          ),
                          SizedBox(height: height / 2 / 10),
                          FadingSlideWidget(
                            offset: Offset(0, 0.5),
                            child: TextButton(
                                onPressed: () {},
                                child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 12, 24, 12),
                                    child: Text(
                                      Globals.letsWorkTogether,
                                      style: context.bodyText1!.copyWith(
                                          color: GlobalColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ),
                        ]),
                  ),
                  FadingSlideWidget(
                    offset: Offset(-1, 0),
                    child: Container(
                        width: width,
                        height: height / 2,
                        color: GlobalColors.lightGrey.withOpacity(.4),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 24),
                            AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Globals.skills.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final skill = Globals.skills[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: Duration(milliseconds: 200),
                                    duration: Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      horizontalOffset: -width / 2,
                                      child: FadeInAnimation(
                                        child: Text(
                                          skill.toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: context.headline1!.copyWith(
                                            // color: Colors.transparent,
                                            fontSize:
                                                (height / 20).clamp(24, 56),

                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = GlobalColors.green
                                                  .withOpacity(.3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 24),
                            FadingSlideWidget(
                                offset: Offset(-1, 0),
                                child: MobileTechStackWidget())
                          ],
                        )),
                  ),
                ],
              ),
              Positioned(
                top: height / 2 - imageSize / 2,
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/avatar.png",
                          width: imageSize, height: imageSize),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 24,
                  right: 24,
                  child: FadingSlideWidget(
                    offset: Offset(0, 2),
                    child: TextButton(
                      style: GlobalStyles.iconButtonStyle(),
                      onPressed: () =>
                          uiMenuManager.updateMenuCommand.execute(1),
                      child: Container(
                          color: GlobalColors.lightGrey.withOpacity(.12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(FontAwesomeIcons.chevronDown,
                                color: Colors.white),
                          )),
                    ),
                  )),
            ],
          )),
    );
  }
}

class MobileTechStackWidget extends StatefulWidget {
  const MobileTechStackWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MobileTechStackWidget> createState() => _TechStackWidgetState();
}

class _TechStackWidgetState extends State<MobileTechStackWidget> {
  bool showStackList = false;

  var techList = Globals.techStack;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final iconSize = 42.0;
    return GestureDetector(
      onVerticalDragUpdate: (drag) {
        setState(() {
          showStackList = !showStackList;
        });
      },
      child: Container(
        width: width * .9,
        child: Column(
          children: [
            SizedBox(
              height: 24,
              child: atkit.AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  atkit.ColorizeAnimatedText(
                    "Tech Stack",
                    colors: [
                      GlobalColors.primaryColor,
                      GlobalColors.lightGrey,
                      GlobalColors.primaryColor
                    ],
                    textStyle: context.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24),
            SizedBox(
              height: 48,
              child: AnimatedOpacity(
                duration: kThemeAnimationDuration,
                // opacity: showStackList ? 1.0 : 0.0,
                opacity: 1.0,
                child: SizedBox(
                  height: 48,
                  child: LiveList(
                    shrinkWrap: true,
                    visibleFraction: 0.5,
                    reAnimateOnVisibility: true,
                    itemCount: Globals.techStack.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 16),
                    itemBuilder: (BuildContext context, int index, animation) {
                      final tech = techList[index];
                      return FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-.4, 0),
                            end: Offset(0, 0),
                          ).animate(animation),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: IconButton(
                              iconSize: iconSize,
                              tooltip: tech.name,
                              padding: EdgeInsets.zero,
                              onPressed: () => launchUrl(Uri.parse(tech.link)),
                              icon: Container(
                                width: iconSize,
                                height: iconSize,
                                decoration: BoxDecoration(
                                  color:
                                      GlobalColors.primaryColor.withOpacity(.4),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/${tech.asset}.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
