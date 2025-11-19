import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/scrollable_image_view.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_collapse.dart';
import 'package:portfol_io/widgets/delayed_display.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AnimatedShowcaseItemWidget extends ConsumerWidget {
  final ShowcaseItem item;
  const AnimatedShowcaseItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final uiShowcaseManager = sl<UiShowcaseManager>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomLeft,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              DelayedDisplay(
                slidingBeginOffset: Offset.zero,
                fadingDuration: const Duration(milliseconds: 100),
                child: ImageView(item: item),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(24),
                    child: IconButton(
                      color: themeColor,
                      hoverColor: themeColor,
                      style: IconButton.styleFrom(
                        backgroundColor: themeColor.withAlpha(102),
                      ),
                      onPressed: () => onPrevious(ref, uiShowcaseManager),
                      icon: const Center(
                        child: Icon(
                          CupertinoIcons.chevron_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(24),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: themeColor.withAlpha(102),
                      ),
                      color: themeColor,
                      hoverColor: themeColor,
                      focusColor: themeColor,
                      onPressed: () => onNext(ref, uiShowcaseManager),
                      icon: const Center(
                        child: Icon(
                          CupertinoIcons.chevron_forward,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          HoverWidget(builder: (context, hovering) {
            return ClipRRect(
              clipBehavior: Clip.antiAlias, // Use a clip  option.
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                width: context.width,
                decoration: BoxDecoration(
                  color: theme.containerColor.withAlpha(179),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: ProAnimatedBlur(
                  blur: hovering ? 32 : 0,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 100),
                                fadingDuration: kThemeAnimationDuration,
                                child: SelectableText(
                                  item.projectName,
                                  textAlign: TextAlign.left,
                                  style: context.headline5?.copyWith(
                                    color: themeColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 200),
                                fadingDuration: kThemeAnimationDuration,
                                child: SelectableText(
                                  item.duration,
                                  textAlign: TextAlign.left,
                                  style: context.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18,
                                    color: theme.inverseTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 12,
                            children: [
                              if (item.publishedGooglePlayUrl != null)
                                DelayedDisplay(
                                  delay: const Duration(milliseconds: 300),
                                  child: IconButton(
                                    splashColor: themeColor,
                                    highlightColor: Colors.transparent,
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: GlobalStyles.borderRadius,
                                      ),
                                      backgroundColor:
                                          themeColor.withAlpha(78),
                                    ),
                                    onPressed: () async {
                                      await launchUrlString(
                                          item.publishedGooglePlayUrl!);
                                    },
                                    icon: SvgPicture.asset(AppIcons.playStore),
                                  ),
                                ),
                              if (item.publishedAppStoreUrl != null)
                                DelayedDisplay(
                                  delay: const Duration(milliseconds: 500),
                                  child: IconButton(
                                    splashColor: themeColor,
                                    highlightColor: Colors.transparent,
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: GlobalStyles.borderRadius,
                                      ),
                                      backgroundColor:
                                          themeColor.withAlpha(78),
                                    ),
                                    onPressed: () async {
                                      await launchUrlString(
                                          item.publishedAppStoreUrl!);
                                    },
                                    icon: SvgPicture.asset(AppIcons.appStore),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      AnimatedCollapse(
                        collapsed: !hovering,
                        duration: const Duration(milliseconds: 100),
                        child: DelayedDisplay(
                          fadingDuration: kThemeAnimationDuration,
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  // accessible text line length
                                  maxWidth: context.width * 4 / 12,
                                ),
                                child: SelectableText(
                                  item.description,
                                  maxLines: 5,
                                  textAlign: TextAlign.left,
                                  style: context.bodyText2!.copyWith(
                                    color: theme.inverseTextColor,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  void onPrevious(WidgetRef ref, UiShowcaseManager manager) {
    final index = manager.previousItemIndex(item);
    ref.read(workIndexProvider.notifier).update((state) => index);
    manager.onPreviousItem();
  }

  void onNext(WidgetRef ref, UiShowcaseManager manager) {
    final index = manager.nextItemIndex(item);
    ref.read(workIndexProvider.notifier).update((state) => index);
    manager.onNextItem();
  }
}

class MobileAnimatedShowcaseItemWidget extends StatelessWidget {

  const MobileAnimatedShowcaseItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    return carousel.CarouselSlider.builder(
      itemCount: uiShowcaseManager.showcaseItems.length,
      options: carousel.CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        aspectRatio: 9 / 16,
        onPageChanged: (index, reason) {
          uiShowcaseManager.currentItemCommand.execute(index);
        },
      ),
      itemBuilder: (context, index, __) {
        final item = uiShowcaseManager.showcaseItems[index];
        return MobileAnimatedShowcaseItemView(item: item);
      },
    );
  }
}

class MobileAnimatedShowcaseItemView extends StatelessWidget {
  final ShowcaseItem item;
  const MobileAnimatedShowcaseItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder(
      key: Key(item.projectName),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, double value, _) {
        return TweenAnimationBuilder(
          key: Key(item.projectName),
          tween: Tween<double>(begin: 25.0, end: 0.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, double value2, _) {
            return Transform.translate(
              offset: Offset(0, value2),
              child: Opacity(
                opacity: value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    MobileImageCarousel(
                      item: item,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 48,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.projectName,
                                        textAlign: TextAlign.left,
                                        style: context.headline5!.copyWith(
                                          color: context.theme.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        spacing: 12,
                                        children: [
                                          if (item.publishedGooglePlayUrl !=
                                              null)
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                iconSize: 20,
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    context.theme.primaryColor,
                                              ),
                                              icon: SvgPicture.asset(
                                                AppIcons.playStore,
                                                width: 20,
                                                height: 20,
                                              ),
                                              onPressed: () {
                                                launchUrlString(item
                                                    .publishedGooglePlayUrl!);
                                              },
                                            ),
                                          if (item.publishedAppStoreUrl != null)
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    context.theme.primaryColor,
                                              ),
                                              icon: SvgPicture.asset(
                                                AppIcons.appStore,
                                                width: 20,
                                                height: 20,
                                              ),
                                              onPressed: () {
                                                launchUrlString(
                                                    item.publishedAppStoreUrl!);
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  item.duration,
                                  textAlign: TextAlign.left,
                                  style: context.headline6!.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width,
                              child: Text(
                                item.description,
                                maxLines: 5,
                                textAlign: TextAlign.left,
                                style: context.bodyText1!
                                    .copyWith(
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
