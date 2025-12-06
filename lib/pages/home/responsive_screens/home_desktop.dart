import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/helpers/email_helper.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/models/tech_item.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/primary_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeDesktop extends ConsumerStatefulWidget {
  const HomeDesktop({super.key});

  @override
  ConsumerState<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends ConsumerState<HomeDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final previousColor = ref.watch(previousThemeColorProvider);
    final nextColor = ref.watch(themeColorProvider);
    return TweenAnimationBuilder<Color?>(
      // <-- Color might be null
      tween: ColorTween(begin: previousColor, end: nextColor),
      duration: const Duration(milliseconds: 300),
      builder: (_, Color? themeColor, __) {
        return Column(
          spacing: 48,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                Size(
                  Globals.maxBoxWidth,
                  context.height,
                ),
              ),
              child: Motion(
                controller: MotionController(
                  damping: 0.5,
                  maxAngle: 0.1,
                ),
                translation: const TranslationConfiguration(
                  maxOffset: Offset(0.1, 0.1),
                ),
                shadow: const ShadowConfiguration(
                  opacity: 0,
                ),
                glare: const GlareConfiguration(
                  minOpacity: 0,
                  maxOpacity: 0,
                  color: Colors.transparent,
                ),
                child: Row(
                  spacing: 0,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //left
                    Expanded(
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 300),
                        slidingBeginOffset: const Offset(0.0, 0.1),
                        child: Container(
                          margin: const EdgeInsets.all(48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 48,
                            children: [
                              DefaultTextStyle(
                                style: theme.nameStyleLarge!.copyWith(
                                  fontSize: context.width < Globals.maxBoxWidth
                                      ? 64
                                      : 96,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 24,
                                      children: [
                                        const Text("I"),
                                        Flexible(
                                          child: DefaultTextStyle(
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                            style:
                                                theme.nameStyleLarge!.copyWith(
                                              color: themeColor,
                                              fontSize: context.width <
                                                      Globals.maxBoxWidth
                                                  ? 64
                                                  : 96,
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
                                    const Text("value."),
                                  ],
                                ),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 800),
                                slidingBeginOffset: const Offset(0.0, 0.1),
                                child: AppPrimaryButton(
                                  onPressed: () {
                                    EmailHelper.contactMe();
                                  },
                                  label: Globals.letsWorkTogether,
                                  icon: AppIcons.coffee,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // DelayedDisplay(
                    //   delay: const Duration(milliseconds: 1000),
                    //   slidingBeginOffset: const Offset(0, 2),
                    //   slidingCurve: Curves.easeInOut,
                    //   fadingDuration: const Duration(milliseconds: 300),
                    //   child: InkWell(
                    //     splashFactory: NoSplash.splashFactory,
                    //     onTap: () => uiMenuManager.setPage(1),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(
                    //         spacing: 8,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text(
                    //             "Scroll down",
                    //             style: context.bodyText1,
                    //           ),
                    //           Icon(
                    //             FontAwesomeIcons.arrowDownLong,
                    //             color: context.theme.inverseTextColor,
                    //             size: 20,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 800),
                        hasSlide: false,
                        child: Container(
                          margin: const EdgeInsets.all(48),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(256),
                            gradient: LinearGradient(
                              colors: [
                                context.theme.primaryColor.withAlpha(0),
                                context.theme.primaryColor.withAlpha(64),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  context.theme.inverseTextColor.withAlpha(0),
                                  context.theme.inverseTextColor,
                                ],
                              ),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    context.theme.inverseTextColor.withAlpha(4),
                                blurRadius: 24,
                                offset: const Offset(0, 48),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(256),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(
                                AppImages.me,
                                height: context.width > Globals.maxBoxWidth
                                    ? Globals.profileImageSizeBig
                                    : Globals.profileImageSizeSmall,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Align(
                    //             alignment: Alignment.topCenter,
                    //             child: Container(
                    //               margin: const EdgeInsets.only(left: 48),
                    //               padding: const EdgeInsets.all(24),
                    //               alignment: Alignment.topRight,
                    //               child: DelayedDisplay(
                    //                 delay: const Duration(seconds: 2),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   crossAxisAlignment: CrossAxisAlignment.end,
                    //                   children: [
                    //                     const SizedBox(height: 48 + 24),
                    //                     ...List.generate(
                    //                       Globals.highlightList.length,
                    //                       (index) {
                    //                         return AnimatedHighlightWidget(
                    //                             index: index);
                    //                       },
                    //                     ).expandWithSeparator(
                    //                       (element) => element,
                    //                       const SizedBox(
                    //                         height: 24,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                  ],
                ),
              ),
            ),
            const AboutMe(),
            const Expertise(),
          ],
        );
      },
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Globals.maxBoxWidth),
      child: DefaultTextStyle(
        style: context.bodyText1!.copyWith(
          fontWeight: FontWeight.w100,
        ),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                Globals.aboutMe,
                style: context.headline5?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Globals.aboutMeDesc1,
                    style: context.bodyText1?.copyWith(
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    Globals.aboutMeDesc2,
                    style: context.bodyText1?.copyWith(
                      fontFamily: 'Playfair Display',
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Container(
                        height: 1,
                        width: 128,
                        color: context.theme.inverseTextColor,
                      ),
                      Text(
                        'Ervin Dobri'.toUpperCase(),
                        style: context.bodyText1?.copyWith(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Expertise extends StatelessWidget {
  const Expertise({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Globals.maxBoxWidth),
      child: DefaultTextStyle(
        style: context.bodyText1!.copyWith(
          fontWeight: FontWeight.w100,
        ),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                Globals.expertise,
                style: context.headline5?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Wrap(
                children: [
                  ...Globals.techStack.map(
                    (e) => TechItemWidget(item: e),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TechItemWidget extends ConsumerWidget {
  const TechItemWidget({
    super.key,
    required this.item,
  });

  final TechItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    final theme = ref.watch(themeProvider);
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        await launchUrlString(item.link);
        HapticFeedback.lightImpact();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: themeColor.withAlpha(102),
            period: const Duration(seconds: 10),
            highlightColor: themeColor,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeColor,
                ),
                borderRadius: BorderRadius.circular(12),
                color: themeColor.withAlpha(102),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Image.asset(
                    item.asset,
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    item.name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Image.asset(
                item.asset,
                width: 20,
                height: 20,
              ),
              Text(
                item.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
