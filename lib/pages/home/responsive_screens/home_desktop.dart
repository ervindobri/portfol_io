import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:portfol_io/pages/home/widgets/bg_shapes.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_highlight_widget.dart';
import 'package:portfol_io/widgets/animated_icon_button.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:portfol_io/extensions/list.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeProvider);
    final previousColor = ref.watch(previousThemeColorProvider);
    final nextColor = ref.watch(themeColorProvider);
    return TweenAnimationBuilder<Color?>(
      // <-- Color might be null
      tween: ColorTween(begin: previousColor, end: nextColor),
      duration: const Duration(milliseconds: 300),
      builder: (_, Color? themeColor, __) {
        // <-- Colo
        return ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(
              Globals.maxBoxWidth,
              context.height,
            ),
          ),
          child: ClipRRect(
            child: SizedBox(
              height: height,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  //Content
                  SizedBox(
                    height: height - kToolbarHeight * 3,
                    child: Row(
                      children: [
                        //left
                        Expanded(
                          child: DelayedDisplay(
                            slidingBeginOffset: const Offset(-1, 0),
                            delay: const Duration(seconds: 1),
                            child: Motion(
                              controller: MotionController(),
                              glare: const GlareConfiguration(
                                maxOpacity: 0,
                                minOpacity: 0,
                                color: Colors.transparent,
                              ),
                              shadow: const ShadowConfiguration(
                                opacity: 0,
                                color: Colors.transparent,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.containerColor,
                                  borderRadius: GlobalStyles.homeRadius,
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(48),
                                margin:
                                    const EdgeInsets.only(top: kToolbarHeight),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 48),
                                        Row(
                                          children: [
                                            Text(
                                              Globals.titleText1,
                                              style: theme.nameStyleSmall
                                                  ?.copyWith(
                                                fontSize: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        DefaultTextStyle(
                                          style: theme.nameStyleLarge?.copyWith(
                                                fontSize: context.width <
                                                        Globals.maxBoxWidth
                                                    ? 64
                                                    : 96,
                                              ) ??
                                              const TextStyle(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                // spacing: 24,
                                                children: [
                                                  const Text("I"),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    // width: context.width,
                                                    child: DefaultTextStyle(
                                                      style: theme
                                                          .nameStyleLarge!
                                                          .copyWith(
                                                        color: themeColor,
                                                        fontSize: context
                                                                    .width <
                                                                Globals
                                                                    .maxBoxWidth
                                                            ? 64
                                                            : 96,
                                                      ),
                                                      child: AnimatedTextKit(
                                                        repeatForever: true,
                                                        pause: const Duration(
                                                            seconds: 2),
                                                        animatedTexts: [
                                                          ...Globals
                                                              .animatedSkills
                                                              .map(
                                                            (e) =>
                                                                TyperAnimatedText(
                                                              e,
                                                              speed:
                                                                  const Duration(
                                                                milliseconds:
                                                                    200,
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
                                        const SizedBox(height: 16),
                                        Wrap(
                                          spacing: 16,
                                          runSpacing: 16,
                                          children: [
                                            ...Globals.techStack.map(
                                              (e) => TechItemWidget(item: e),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style:
                                              GlobalStyles.primaryButtonStyle(
                                                  theme),
                                          onPressed: () async {
                                            await EmailHelper.contactMe();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 24, horizontal: 24),
                                            child: Row(
                                              children: [
                                                Text(
                                                  Globals.hireMe,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              theme.textColor),
                                                ),
                                                const SizedBox(width: 24),
                                                SvgPicture.asset(
                                                  AppIcons.coffee,
                                                  height: 32,
                                                  width: 32,
                                                  colorFilter: ColorFilter.mode(
                                                    theme.textColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        DelayedDisplay(
                                          delay: const Duration(
                                              milliseconds: 1000),
                                          slidingBeginOffset:
                                              const Offset(0, 2),
                                          slidingCurve: Curves.easeInOut,
                                          fadingDuration:
                                              const Duration(milliseconds: 300),
                                          child: AnimatedIconButton(
                                            onPressed: () =>
                                                uiMenuManager.setPage(1),
                                            icon: const Icon(
                                              FontAwesomeIcons.chevronDown,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                        Expanded(
                          child: DelayedDisplay(
                            slidingBeginOffset: const Offset(1, 0),
                            delay: const Duration(seconds: 2),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: kToolbarHeight),
                              child: Stack(
                                children: [
                                  const BGShapes(),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 48),
                                      decoration: BoxDecoration(
                                        color: themeColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(666),
                                          bottomLeft: Radius.circular(24),
                                          bottomRight: Radius.circular(128),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(24),
                                      alignment: Alignment.topRight,
                                      child: DelayedDisplay(
                                        delay: const Duration(seconds: 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(height: 48 + 24),
                                            ...List.generate(
                                              Globals.highlightList.length,
                                              (index) {
                                                return AnimatedHighlightWidget(
                                                    index: index);
                                              },
                                            ).expandWithSeparator(
                                              (element) => element,
                                              const SizedBox(
                                                height: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -24,
                                    bottom: 0,
                                    child: DelayedDisplay(
                                      slidingBeginOffset: const Offset(0, 2),
                                      delay: const Duration(seconds: 2),
                                      child: HoverWidget(
                                        builder: (context, hovering) {
                                          return AnimatedScale(
                                            duration: kThemeAnimationDuration,
                                            scale: hovering ? 1.025 : 1,
                                            child: Image.asset(
                                              AppImages.me,
                                              height: context.width >
                                                      Globals.maxBoxWidth
                                                  ? Globals.profileImageSizeBig
                                                  : Globals
                                                      .profileImageSizeSmall,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: themeColor.withOpacity(.4),
            period: const Duration(seconds: 10),
            highlightColor: themeColor,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeColor,
                ),
                borderRadius: BorderRadius.circular(12),
                color: themeColor.withOpacity(.4),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item.asset,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
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
            children: [
              Image.asset(
                item.asset,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
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
