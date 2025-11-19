import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/home/responsive_screens/home_desktop.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_highlight_widget.dart';

enum Orientation { portrait, landscape }

class HomeMobile extends ConsumerStatefulWidget {
  final Orientation orientation;
  const HomeMobile._({required this.orientation});

  factory HomeMobile.portrait() =>
      const HomeMobile._(orientation: Orientation.portrait);
  factory HomeMobile.landscape() =>
      const HomeMobile._(orientation: Orientation.landscape);

  @override
  ConsumerState<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<HomeMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    return SizedBox(
      width: width,
      child: Column(
        spacing: 24,
        children: [
          //left
          SizedBox(
            height: height,
            child: Container(
              decoration: BoxDecoration(
                color: theme.containerColor,
                borderRadius: GlobalStyles.homeRadius,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 24,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        FadingSlideWidget(
                          offset: const Offset(0, 0.1),
                          durationMilliseconds: 200,
                          child: Row(
                            children: [
                              Text(
                                Globals.titleText1,
                                style: theme.nameStyleSmall?.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DefaultTextStyle(
                          style: theme.nameStyleLarge!.copyWith(
                            fontSize: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("I"),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    // width: context.width,
                                    child: DefaultTextStyle(
                                      style: theme.nameStyleLarge!.copyWith(
                                        color: themeColor,
                                        fontSize: 32,
                                      ),
                                      child: AnimatedTextKit(
                                        repeatForever: true,
                                        pause: const Duration(seconds: 2),
                                        animatedTexts: [
                                          ...Globals.animatedSkills.map(
                                            (e) => TyperAnimatedText(
                                              e,
                                              speed: const Duration(
                                                milliseconds: 200,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text("value"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: width,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: width,
                          height: 250,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(666),
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(128),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            // Shadow layer
                            Positioned.fill(
                              left: 36,
                              child: Opacity(
                                opacity: 0.25,
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 12,
                                    sigmaY: 6,
                                  ),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withAlpha(155),
                                      BlendMode.srcATop,
                                    ),
                                    child: Image.asset(
                                      AppImages.me,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              width: width,
                              child: Image.asset(
                                AppImages.me,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: GlobalStyles.primaryButtonStyle(theme),
                        onPressed: () async {
                          await EmailHelper.contactMe();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Globals.hireMe,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SvgPicture.asset(
                                AppIcons.coffee,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  theme.textColor,
                                  BlendMode.srcIn,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 16,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        runSpacing: 16,
                        children: [
                          ...Globals.techStack.map(
                            (e) => TechItemWidget(item: e),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(64),
                bottomRight: Radius.circular(64),
              ),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 12,
              children: [
                ...List.generate(
                  Globals.highlightList.length,
                  (index) {
                    return AnimatedHighlightMobileWidget(index: index);
                  },
                ),
              ],
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
                      color: GlobalColors.lightGrey.withAlpha(140),
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
