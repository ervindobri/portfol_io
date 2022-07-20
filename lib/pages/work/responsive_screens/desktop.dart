import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart' as atkit;
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/styles.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:portfol_io/injection_manager.dart';

class WorkDesktop extends StatefulWidget {
  WorkDesktop({Key? key}) : super(key: key);

  @override
  State<WorkDesktop> createState() => _WorkDesktopState();
}

class _WorkDesktopState extends State<WorkDesktop> {
  final uiMenuManager = sl<UiMenuManager>();
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    return ClipRRect(
      child: SizedBox(
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
              //Content
              SizedBox(
                width: width,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(48, 48 + 60, 48, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          Globals.showcase,
                          style:
                              context.headline6!.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: width,
                        height: height * .8 - 96 - 32 - 32,
                        // color: GlobalColors.lightGrey.withOpacity(.4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: AnimatedShowcaseItemWidget(),
                        ),
                      ),
                      SizedBox(height: 16),
                      CarouselController(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class TechStackWidget extends StatefulWidget {
  const TechStackWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TechStackWidget> createState() => _TechStackWidgetState();
}

class _TechStackWidgetState extends State<TechStackWidget> {
  bool showStackList = false;

  var techList = Globals.techStack;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (d) {
        setState(() {
          showStackList = false;
        });
      },
      child: Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MouseRegion(
            onHover: (hovering) {
              setState(() {
                showStackList = true;
              });
            },
            child: SizedBox(
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
          ),
          SizedBox(width: 16),
          MouseRegion(
            child: Container(
              child: Row(
                children: [
                  AnimatedOpacity(
                    duration: kThemeAnimationDuration,
                    opacity: showStackList ? 0.0 : 1.0,
                    child: SizedBox(
                      child: Icon(FontAwesomeIcons.angleDoubleRight,
                          size: 16, color: GlobalColors.lightGrey),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: kThemeAnimationDuration,
                    opacity: showStackList ? 1.0 : 0.0,
                    child: SizedBox(
                      width: 344,
                      height: 48,
                      child: LiveList(
                        shrinkWrap: true,
                        visibleFraction: 0.5,
                        reAnimateOnVisibility: true,
                        itemCount: Globals.techStack.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 16),
                        itemBuilder:
                            (BuildContext context, int index, animation) {
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
                                  iconSize: 48,
                                  tooltip: tech.name,
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    print(tech.link);
                                  },
                                  icon: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: GlobalColors.primaryColor
                                          .withOpacity(.4),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
