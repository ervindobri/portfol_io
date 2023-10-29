import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:animated_text_kit/animated_text_kit.dart' as atkit;

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
    final width = MediaQuery.of(context).size.width;
    return MouseRegion(
      onExit: (d) {
        setState(() {
          showStackList = false;
        });
      },
      child: Row(
        children: [
          MouseRegion(
            onHover: (hovering) {
              setState(() {
                showStackList = true;
              });
            },
            child: SizedBox(
              height: 24,
              child: Center(
                child: atkit.AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    atkit.ColorizeAnimatedText(
                      "Tech Stack",
                      textAlign: TextAlign.center,
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
          ),
          const SizedBox(width: 16),
          MouseRegion(
            child: Row(
              children: [
                AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: showStackList ? 0.0 : 1.0,
                  child: const SizedBox(
                    height: 24,
                    child: Icon(
                      FontAwesomeIcons.angleDoubleRight,
                      size: 16,
                      color: GlobalColors.lightGrey,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: showStackList ? 1.0 : 0.0,
                  child: SizedBox(
                    width: width / 4,
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
                              end: const Offset(0, 0),
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
        ],
      ),
    );
  }
}
