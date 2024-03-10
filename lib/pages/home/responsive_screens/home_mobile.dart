import 'package:animated_text_kit/animated_text_kit.dart' as atkit;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/styles.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:url_launcher/url_launcher.dart';

enum Orientation { portrait, landscape }

class HomeMobile extends StatefulWidget {
  final Orientation orientation;
  const HomeMobile._({required this.orientation});

  factory HomeMobile.portrait() =>
      const HomeMobile._(orientation: Orientation.portrait);
  factory HomeMobile.landscape() =>
      const HomeMobile._(orientation: Orientation.landscape);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pageHeight =
        widget.orientation == Orientation.landscape ? width : height;
    final topPadding = 48 + height / 20;
    const double mobilePadding = 16;
    const mobileAnimationDurationMs = 300;
    final dynamicFontSize = widget.orientation == Orientation.landscape
        ? height / 10
        : (width / 17);
    return SizedBox(
      height: pageHeight,
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              FadingSlideWidget(
                offset: const Offset(0, .1),
                durationMilliseconds: mobileAnimationDurationMs,
                child: Container(
                  width: width,
                  height: pageHeight / 2,
                  padding: EdgeInsets.fromLTRB(
                    mobilePadding,
                    topPadding,
                    mobilePadding,
                    mobilePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: width * .6,
                        child: Text(
                          Globals.title,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          style: context.headline6?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        Globals.subtitle,
                        textAlign: TextAlign.right,
                        style: context.bodyText2?.copyWith(
                          color: GlobalColors.lightGrey,
                        ),
                      ),
                      const SizedBox(height: 48),
                      TextButton(
                        onPressed: () async {
                           await EmailHelper.contactMe();        
                        },
                        style: GlobalStyles.whiteTextButtonStyle(),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                          child: Text(
                            Globals.letsWorkTogether,
                            style: context.bodyText1?.copyWith(
                                color: GlobalColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadingSlideWidget(
                offset: const Offset(-1, 0),
                durationMilliseconds: mobileAnimationDurationMs,
                child: Container(
                    width: width,
                    height: pageHeight / 2,
                    color: GlobalColors.darkGrey,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(mobilePadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadingSlideWidget(
                          offset: const Offset(-1, 0),
                          durationMilliseconds: mobileAnimationDurationMs,
                          child: widget.orientation == Orientation.landscape
                              ? MobileTechStackWidget.landscape()
                              : MobileTechStackWidget.portrait(),
                        ),
                        const SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Globals.skills.take(5).length,
                          itemBuilder: (BuildContext context, int index) {
                            final skill = Globals.skills[index];
                            var list = [...Globals.skills];
                            list.remove(skill);
                            list.shuffle();
                            const speed = Duration(milliseconds: 200);
                            return DefaultTextStyle(
                              style: context.headline1!.copyWith(
                                fontSize: dynamicFontSize.clamp(24, 48),
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = GlobalColors.green.withOpacity(.9),
                              ),
                              child: atkit.AnimatedTextKit(
                                repeatForever: true,
                                pause: const Duration(seconds: 3),
                                animatedTexts: [
                                  atkit.TyperAnimatedText(
                                    skill.toUpperCase(),
                                    speed: speed,
                                  ),
                                  ...list
                                      .map(
                                        (e) => atkit.TyperAnimatedText(
                                          e.toUpperCase(),
                                          speed: speed,
                                        ),
                                      )
                                      ,
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )),
              ),
            ],
          ),
          // Positioned(
          //   top: pageHeight / 4 - imageSize / 2,
          //   left: widget.orientation == Orientation.landscape ? imageSize : 0,
          //   child: Container(
          //     width: imageSize,
          //     height: imageSize,
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Image.memory(base64Decode(Globals.avatarImageBase64),
          //             width: imageSize, height: imageSize),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: mobilePadding,
            right: mobilePadding,
            child: FadingSlideWidget(
              offset: const Offset(0, 2),
              durationMilliseconds: mobileAnimationDurationMs,
              child: IconButton(
                onPressed: () => uiMenuManager.updateMenuCommand.execute(1),
                iconSize: 42,
                icon: Container(
                  color: GlobalColors.primaryColor.withOpacity(.4),
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileTechStackWidget extends StatefulWidget {
  final Orientation orientation;
  const MobileTechStackWidget._({
    required this.orientation,
  });

  factory MobileTechStackWidget.portrait() =>
      const MobileTechStackWidget._(orientation: Orientation.portrait);

  factory MobileTechStackWidget.landscape() =>
      const MobileTechStackWidget._(orientation: Orientation.landscape);

  @override
  State<MobileTechStackWidget> createState() => _TechStackWidgetState();
}

class _TechStackWidgetState extends State<MobileTechStackWidget> {
  bool showStackList = false;
  var techList = Globals.techStack;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    const iconSize = 42.0;
    return GestureDetector(
      onVerticalDragUpdate: (drag) {
        setState(() {
          showStackList = !showStackList;
        });
      },
      child: SizedBox(
        width: width,
        child: SizedBox(
          height: 48,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Globals.techStack.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final tech = techList[index];
              return Padding(
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
                      color: GlobalColors.lightGrey.withOpacity(.6),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/${tech.asset}.png"),
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
    );
  }
}
