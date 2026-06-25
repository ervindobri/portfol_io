import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/models/tech_item.dart';
import 'package:portfol_io/widgets/animated_text_switcher.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_highlight_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    final imageHeight = height * .65;
    return Column(
      spacing: 24,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: theme.containerColor,
            borderRadius: GlobalStyles.homeRadius,
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              SizedBox(height: context.topPadding + kToolbarHeight),
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
                              const BlurText(text: "I"),
                              const SizedBox(width: 12),
                              Expanded(
                                // width: context.width,
                                child: DefaultTextStyle(
                                  style: theme.nameStyleLarge!.copyWith(
                                    color: themeColor,
                                    fontSize: 32,
                                  ),
                                  child: AnimatedTextSwitcher(
                                    texts: Globals.animatedSkills,
                                    toWidget: (value) => BlurText(
                                      text: value,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const BlurText(text: "value"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: imageHeight - 48 - context.bottomPadding,
                width: width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: imageHeight - 50,
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(666),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(128),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.scale(
                          scale: 1.0,
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            clipBehavior: Clip.none,
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
                                width: width,
                                child: Image.asset(
                                  AppImages.me,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -36,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: GlobalStyles.primaryButtonStyle(theme),
                            onPressed: () async {
                              await EmailHelper.contactMe();
                              HapticFeedback.mediumImpact();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 32),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const AboutMeMobile(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Globals.expertise,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.inverseTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  ...Globals.techStack.map(
                    (e) => MobileTechItemWidget(item: e),
                  )
                ],
              ),
            ],
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
    );
  }
}

class AboutMeMobile extends HookWidget {
  const AboutMeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final animate = useState(false);
    return VisibilityDetector(
      key: const ValueKey('aboutme_mobile'),
      onVisibilityChanged: (visible) {
        animate.value = visible.visibleFraction > 0.2;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Globals.aboutMe,
              style: context.headline5?.copyWith(fontWeight: FontWeight.w500),
            ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  animate: animate.value,
                  child: Text(
                    Globals.aboutMeDesc1,
                    style: context.bodyText1?.copyWith(
                      fontFamily: Globals.fontFamilyPlayfair,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...Globals.aboutMeDesc2.split('\n').map(
                          (e) => Text(
                            e,
                            style: context.bodyText1?.copyWith(
                              fontFamily: Globals.fontFamilyPlayfair,
                              fontSize: 14,
                              color: animate.value ? null : Colors.transparent,
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ),
            SlideInRight(
              animate: animate.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Container(
                        height: 1,
                        width: 64,
                        color: context.theme.inverseTextColor,
                      ),
                      Text(
                        'Ervin Dobri'.toUpperCase(),
                        style: context.bodyText1?.copyWith(
                          fontWeight: FontWeight.w100,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileTechItemWidget extends StatefulWidget {
  const MobileTechItemWidget({super.key, required this.item});
  final TechItem item;

  @override
  State<MobileTechItemWidget> createState() => _MobileTechItemWidgetState();
}

class _MobileTechItemWidgetState extends State<MobileTechItemWidget> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchUrlString(widget.item.link);
        HapticFeedback.lightImpact();
      },
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: Column(
        spacing: 8,
        children: [
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: _pressed
                  ? context.theme.primaryColor
                  : context.theme.containerColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                AnimatedScale(
                  scale: _pressed ? 1.1 : 1.0,
                  duration: kThemeAnimationDuration,
                  child: Image.asset(
                    widget.item.asset,
                    width: 64,
                    height: 64,
                  ),
                ),
                Text(
                  '${widget.item.knowledgePercentage}%',
                  style: context.theme.textTheme.bodySmall
                      ?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            widget.item.name,
            style: context.theme.textTheme.bodySmall?.copyWith(fontSize: 12),
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
