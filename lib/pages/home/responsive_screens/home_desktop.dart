import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:portfol_io/widgets/animated_highlight_widget.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
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
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: height,
                width: width / 2 - 48,
                margin: const EdgeInsets.only(left: 48),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(666),
                    bottomLeft: Radius.circular(48),
                    bottomRight: Radius.circular(128),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                Size(
                  Globals.maxBoxWidth,
                  context.height,
                ),
              ),
              child: Row(
                spacing: 0,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //left
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: kToolbarHeight, right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 24,
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
                                    const Text("value"),
                                  ],
                                ),
                              ),
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
                          DelayedDisplay(
                            delay: const Duration(milliseconds: 2000),
                            child: TextButton(
                              style: GlobalStyles.primaryButtonStyle(theme),
                              onPressed: () async {
                                await EmailHelper.contactMe();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 24),
                                child: Row(
                                  spacing: 24,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      Globals.letsWorkTogether,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(color: theme.textColor),
                                    ),
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
                          ),
                          const Spacer(),
                          DelayedDisplay(
                            delay: const Duration(milliseconds: 3000),
                            slidingBeginOffset: const Offset(0, 2),
                            slidingCurve: Curves.easeInOut,
                            fadingDuration: const Duration(milliseconds: 300),
                            child: InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () => uiMenuManager.setPage(1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  spacing: 8,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Scroll down",
                                      style: context.bodyText1,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.arrowDownLong,
                                      color: context.theme.inverseTextColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: DelayedDisplay(
                      slidingBeginOffset: const Offset(1, 0),
                      delay: const Duration(seconds: 2),
                      child: Container(
                        margin: const EdgeInsets.only(top: kToolbarHeight),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: const EdgeInsets.only(left: 48),
                                padding: const EdgeInsets.all(24),
                                alignment: Alignment.topRight,
                                child: DelayedDisplay(
                                  delay: const Duration(seconds: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                child: Image.asset(
                                  AppImages.me,
                                  height: context.width > Globals.maxBoxWidth
                                      ? Globals.profileImageSizeBig
                                      : Globals.profileImageSizeSmall,
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
