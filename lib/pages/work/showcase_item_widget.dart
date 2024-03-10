import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/scrollable_image_view.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedShowcaseItemWidget extends ConsumerWidget {
  final ShowcaseItem item;
  const AnimatedShowcaseItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomLeft,
      children: [
        ImageView(item: item),
        Padding(
          padding: const EdgeInsets.all(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: context.width,
              decoration: BoxDecoration(
                color: theme.containerColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 32),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 300),
                      fadingDuration: kThemeAnimationDuration,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 4 / 12,
                        ),
                        child: SelectableText(
                          item.description,
                          maxLines: 4,
                          textAlign: TextAlign.left,
                          style: context.bodyText2!.copyWith(
                            color: theme.inverseTextColor,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                    // Spacer(),
                    // TODO: add play/appstore icon if applicable
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileAnimatedShowcaseItemWidget extends StatelessWidget {
  final uiShowcaseManager = sl<UiShowcaseManager>();

  MobileAnimatedShowcaseItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: uiShowcaseManager.showcaseItems.length,
      options: CarouselOptions(
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MobileImageCarousel(item: item),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.projectName,
                                  textAlign: TextAlign.left,
                                  style: context.headline5!.copyWith(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  item.duration,
                                  textAlign: TextAlign.left,
                                  style: context.headline6!.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: width,
                              child: Text(
                                item.description,
                                maxLines: 5,
                                textAlign: TextAlign.left,
                                style: context.bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const Spacer(),
                            Wrap(
                              spacing: 8,
                              children: item.tags
                                  .map(
                                    (e) => Text(
                                      "#${e.toLowerCase()}",
                                      style: context.bodyText2?.copyWith(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 4),
                            TextButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(item.url));
                              },
                              style: GlobalStyles.whiteTextButtonStyle(),
                              child: Container(
                                width: width,
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                child: Center(
                                  child: Text(
                                    Globals.checkItOut,
                                    style: context.bodyText1!.copyWith(
                                        color: GlobalColors.primaryColor,
                                        fontSize: 24,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700),
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
      },
    );
  }
}
