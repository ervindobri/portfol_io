import 'dart:convert';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart' as atkit;
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/styles.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_me_dialog.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:portfol_io/injection_manager.dart';

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
    return ClipRRect(
      child: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //BG Blobs
            //TODO: blobs from memory
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
            //Content
            Row(
              children: [
                FadingSlideWidget(
                  offset: Offset(-1, 0),
                  child: Container(
                    width: width / 2,
                    height: height,
                    color: GlobalColors.lightGrey.withOpacity(.4),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(48),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Globals.skills.take(5).length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final skill = Globals.skills[index];
                                  var list = [...Globals.skills];
                                  list.remove(skill);
                                  list.shuffle();
                                  final speed =
                                      const Duration(milliseconds: 200);
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: Duration(milliseconds: 200),
                                    duration: Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      horizontalOffset: -width / 2,
                                      child: FadeInAnimation(
                                        child: DefaultTextStyle(
                                          style: context.headline1!.copyWith(
                                            fontSize:
                                                (width / 15).clamp(50, 75),
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 2
                                              ..color = GlobalColors.green
                                                  .withOpacity(.7),
                                          ),
                                          child: atkit.AnimatedTextKit(
                                            repeatForever: true,
                                            pause: Duration(seconds: 3),
                                            animatedTexts: [
                                              atkit.TyperAnimatedText(
                                                skill.toUpperCase(),
                                                speed: speed,
                                              ),
                                              ...list
                                                  .map(
                                                    (e) =>
                                                        atkit.TyperAnimatedText(
                                                      e.toUpperCase(),
                                                      speed: speed,
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                        // child: Text(
                                        //   skill.toUpperCase(),
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.fade,
                                        //   style:
                                        //       context.headline1!.copyWith(
                                        //     // color: Colors.transparent,
                                        //     fontSize:
                                        //         (width / 15).clamp(50, 75),

                                        //     foreground: Paint()
                                        //       ..style = PaintingStyle.stroke
                                        //       ..strokeWidth = 2
                                        //       ..color = GlobalColors.green
                                        //           .withOpacity(.3),
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 24,
                          child: FadingSlideWidget(
                            offset: Offset(-1, 0),
                            child: TechStackWidget(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width / 2,
                  height: height,
                  padding: const EdgeInsets.fromLTRB(48, 128 + 60, 48, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FadingSlideWidget(
                        offset: Offset(0, 0.5),
                        child: SizedBox(
                          width: width / 3,
                          child: Text(
                            Globals.title,
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            style: context.headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      FadingSlideWidget(
                        offset: Offset(0, 0.5),
                        child: SizedBox(
                          height: 32,
                          child: DefaultTextStyle(
                            style: context.headline6!
                                .copyWith(color: GlobalColors.lightGrey),
                            child: atkit.AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration.zero,
                              animatedTexts: [
                                atkit.FadeAnimatedText(Globals.subtitle,
                                    duration: const Duration(seconds: 15)),
                                atkit.FadeAnimatedText(Globals.inspiration,
                                    duration: const Duration(seconds: 15)),
                              ],
                            ),
                          ),
                        ),
                        // child: Text(
                        //   Globals.subtitle,
                        //   textAlign: TextAlign.right,
                        // ),
                      ),
                      SizedBox(height: 96),
                      FadingSlideWidget(
                        offset: Offset(0, 0.5),
                        child: TextButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                elevation: 24,
                                child: ContactMeDialog.desktop(),
                              );
                            },
                          ),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                            child: Text(
                              Globals.letsWorkTogether,
                              style: context.headline6!.copyWith(
                                color: GlobalColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        child: Image.memory(
                            base64Decode(Globals.avatarImageBase64),
                            width: imageSize,
                            height: imageSize),
                      ),
                    ),
                    Positioned(
                        child: Image.memory(
                            base64Decode(Globals.avatarImageBase64),
                            width: imageSize,
                            height: imageSize)),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              left: width / 2 + 42,
              child: FadingSlideWidget(
                offset: Offset(0, 2),
                child: TextButton(
                  style: GlobalStyles.iconButtonStyle(),
                  onPressed: () => uiMenuManager.updateMenuCommand.execute(1),
                  child: Container(
                    color: GlobalColors.lightGrey.withOpacity(.12),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Icon(FontAwesomeIcons.chevronDown,
                          color: Colors.white),
                    ),
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
                                    // print(tech.link);
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
