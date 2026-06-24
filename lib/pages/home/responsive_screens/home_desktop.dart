import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
import 'package:portfol_io/widgets/widgets.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeDesktop extends ConsumerStatefulWidget {
  const HomeDesktop({super.key});

  @override
  ConsumerState<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends ConsumerState<HomeDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 48,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LandingContent(),
        Column(
          spacing: 96,
          children: [
            AboutMe(),
            Expertise(),
          ],
        ),
      ],
    );
  }
}

class LandingContent extends ConsumerWidget {
  const LandingContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final previousColor = ref.watch(previousThemeColorProvider);
    final nextColor = ref.watch(themeColorProvider);
    return TweenAnimationBuilder<Color?>(
        // <-- Color might be null
        tween: ColorTween(begin: previousColor, end: nextColor),
        duration: const Duration(milliseconds: 300),
        builder: (_, Color? themeColor, __) {
          return ConstrainedBox(
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
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(48, 48, 0, 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 48,
                        children: [
                          DefaultTextStyle(
                            style: theme.nameStyleLarge!.copyWith(
                              fontSize:
                                  context.width < Globals.maxBoxWidth ? 64 : 96,
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
                                        style: theme.nameStyleLarge!.copyWith(
                                          color: themeColor,
                                          fontSize: context.width <
                                                  Globals.maxBoxWidth
                                              ? 64
                                              : 96,
                                        ),
                                        child: AnimatedTextSwitcher(
                                          texts: Globals.animatedSkills,
                                          initialDelay:
                                              const Duration(milliseconds: 800),
                                          toWidget: (value) => BlurText(
                                            key: ValueKey(value),
                                            type: AnimationType.letter,
                                            text: value,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text("value."),
                              ],
                            ),
                          ),
                          AppPrimaryButton(
                            onPressed: () {
                              EmailHelper.contactMe();
                            },
                            label: Globals.letsWorkTogether,
                            icon: AppIcons.coffee,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 800),
                      hasSlide: false,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 48, 48, 48),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(256),
                          gradient: LinearGradient(
                            colors: [
                              context.theme.primaryColor.withAlpha(
                                  theme.brightness == Brightness.dark ? 0 : 64),
                              context.theme.primaryColor.withAlpha(
                                  theme.brightness == Brightness.dark
                                      ? 64
                                      : 128),
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
                              color: context.theme.primaryColor.withAlpha(16),
                              blurRadius: 24,
                              offset: const Offset(0, 24),
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
                ],
              ),
            ),
          );
        });
  }
}

class AboutMe extends HookWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final animate = useState(false);
    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        animate.value = visible.visibleFraction > 0.2;
      },
      key: const ValueKey('aboutme'),
      child: SelectableRegion(
        selectionControls: DesktopTextSelectionControls(),
        child: ConstrainedBox(
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
                      FadeIn(
                        animate: animate.value,
                        child: Text(
                          Globals.aboutMeDesc1,
                          style: context.bodyText1?.copyWith(
                            fontFamily: Globals.fontFamilyPlayfair,
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
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
                                      fontSize: 24,
                                      color: animate.value
                                          ? null
                                          : Colors.transparent),
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                SlideInRight(
                  animate: animate.value,
                  child: Row(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Expertise extends HookWidget {
  const Expertise({super.key});

  @override
  Widget build(BuildContext context) {
    final animate = useState(false);
    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        animate.value = visible.visibleFraction > 0.3;
      },
      key: const ValueKey('expertise'),
      child: ConstrainedBox(
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
              DelayedDisplay(
                delay: const Duration(milliseconds: 1400),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...Globals.techStack.mapIndexed(
                        (index, e) => FadeIn(
                          animate: animate.value,
                          delay: Duration(milliseconds: 50 * index),
                          child: TechItemWidget(item: e),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TechItemWidget extends StatelessWidget {
  const TechItemWidget({
    super.key,
    required this.item,
  });

  final TechItem item;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(builder: (context, hovering) {
      return GestureDetector(
        onTap: () async {
          await launchUrlString(item.link);
          HapticFeedback.lightImpact();
        },
        child: Column(
          spacing: 16,
          children: [
            AnimatedContainer(
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: hovering
                    ? context.theme.primaryColor
                    : context.theme.containerColor,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  AnimatedScale(
                    scale: hovering ? 1 : 0.8,
                    duration: kThemeAnimationDuration,
                    child: ColorFiltered(
                      colorFilter: hovering
                          ? const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            )
                          : Globals.greyscaleColorFilter,
                      child: Image.asset(
                        item.asset,
                        width: 96,
                        height: 96,
                      ),
                    ),
                  ),
                  Text(
                    '${item.knowledgePercentage.toString()}%',
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            SlideInUp(
              child: Text(
                item.name,
                style: context.theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      );
    });
  }
}
