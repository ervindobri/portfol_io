import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/scrollable_image_view.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedShowcaseItemWidget extends ConsumerWidget {
  final ShowcaseItem item;
  const AnimatedShowcaseItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: ImageView(item: item),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: theme.containerColor,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 100),
                      fadingDuration: kThemeAnimationDuration,
                      child: Text(
                        item.projectName,
                        textAlign: TextAlign.left,
                        style: context.headline4!.copyWith(color: Colors.white),
                      ),
                    ),
                    DelayedDisplay(
                      delay: const Duration(
                        milliseconds: 200,
                      ),
                      fadingDuration: kThemeAnimationDuration,
                      child: Text(
                        item.duration,
                        textAlign: TextAlign.left,
                        style: context.headline6!.copyWith(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: GlobalColors.lightGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 300),
                      fadingDuration: kThemeAnimationDuration,
                      child: Text(
                        item.description,
                        maxLines: 12,
                        textAlign: TextAlign.left,
                        style: context.bodyText1!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                // //tags
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     AnimatedTextKit(
                //       // spacing: 8,
                //       repeatForever: true,
                //       pause: const Duration(seconds: 2),
                //       animatedTexts: item.tags
                //           .map(
                //             (e) => TyperAnimatedText(
                //               "#${e.toLowerCase()}",
                //               speed: const Duration(
                //                   milliseconds: 50),
                //               textStyle: context.headline4
                //                   ?.copyWith(
                //                       fontWeight:
                //                           FontWeight.w100),
                //             ),
                //           )
                //           .toList(),
                //     ),
                //     const SizedBox(height: 16),
                //     //action
                //     Row(
                //       mainAxisAlignment:
                //           MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         DelayedDisplay(
                //           delay:
                //               const Duration(milliseconds: 100),
                //           slidingBeginOffset: const Offset(-1, 0),
                //           child: Row(
                //             children: [
                //               if (item.publishedGooglePlayUrl !=
                //                   null)
                //                 Tooltip(
                //                   message:
                //                       'Open android app link',
                //                   child: IconButton(
                //                     iconSize: 42,
                //                     padding: EdgeInsets.zero,
                //                     icon: Container(
                //                       color: Colors.white
                //                           .withOpacity(.5),
                //                       padding:
                //                           const EdgeInsets.all(8),
                //                       child: Image.asset(
                //                           "assets/icons/play-store.png",
                //                           color: Colors.white),
                //                     ),
                //                     onPressed: () {
                //                       launchUrlString(item
                //                           .publishedGooglePlayUrl!);
                //                     },
                //                   ),
                //                 ),
                //               const SizedBox(width: 16),
                //               if (item.publishedAppStoreUrl !=
                //                   null)
                //                 Tooltip(
                //                   message: 'Open iOS app link',
                //                   child: IconButton(
                //                     iconSize: 42,
                //                     padding: EdgeInsets.zero,
                //                     icon: Container(
                //                       color: Colors.white
                //                           .withOpacity(.5),
                //                       padding:
                //                           const EdgeInsets.all(8),
                //                       child: Image.asset(
                //                           "assets/icons/app-store.png",
                //                           color: Colors.white),
                //                     ),
                //                     onPressed: () {
                //                       launchUrlString(item
                //                           .publishedAppStoreUrl!);
                //                     },
                //                   ),
                //                 ),
                //             ],
                //           ),
                //         ),
                //         TextButton(
                //           onPressed: () async {
                //             await launchUrl(Uri.parse(item.url));
                //           },
                //           style:
                //               GlobalStyles.whiteTextButtonStyle(),
                //           child: Container(
                //             color: Colors.white,
                //             padding: const EdgeInsets.fromLTRB(
                //                 24, 12, 24, 12),
                //             child: Text(
                //               Globals.checkItOut,
                //               style: context.headline6!.copyWith(
                //                   color:
                //                       GlobalColors.primaryColor),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MobileAnimatedShowcaseItemWidget extends StatelessWidget {
  final uiShowcaseManager = sl<UiShowcaseManager>();

  MobileAnimatedShowcaseItemWidget({Key? key}) : super(key: key);

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
  const MobileAnimatedShowcaseItemView({Key? key, required this.item})
      : super(key: key);

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
