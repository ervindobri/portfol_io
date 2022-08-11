import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/image_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedShowcaseItemWidget extends StatelessWidget {
  final uiShowcaseManager = sl<UiShowcaseManager>();

  AnimatedShowcaseItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //TODO: fix issue with key listener
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem?>>(
      valueListenable: uiShowcaseManager.currentItemCommand.results,
      builder: (context, value, __) {
        if (value.data == null) {
          return SizedBox();
        }
        final item = value.data!;
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0, value2),
                        child: Opacity(
                          opacity: value,
                          child: ImageCarousel(item: item),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: Offset(0, value2),
                            child: Opacity(
                              opacity: value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.projectName,
                                    textAlign: TextAlign.left,
                                    style: context.headline4!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    item.duration,
                                    textAlign: TextAlign.left,
                                    style: context.headline6!.copyWith(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 24,
                                        color: Colors.white),
                                  ),
                                  SizedBox(height: 24),
                                  SizedBox(
                                    width: width / 3,
                                    child: Text(
                                      item.description,
                                      maxLines: 10,
                                      textAlign: TextAlign.left,
                                      style: context.bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          //tags
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Wrap(
                                    spacing: 8,
                                    children: item.tags
                                        .map(
                                          (e) => Text(
                                            "#${e.toLowerCase()}",
                                            style: context.bodyText2?.copyWith(
                                                fontWeight: FontWeight.w100),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 16),
                                  //action
                                  TextButton(
                                      onPressed: () async {
                                        await launchUrl(Uri.parse(item.url));
                                      },
                                      style:
                                          GlobalStyles.whiteTextButtonStyle(),
                                      child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.fromLTRB(
                                              24, 12, 24, 12),
                                          child: Text(
                                            Globals.checkItOut,
                                            style: context.headline6!.copyWith(
                                                color:
                                                    GlobalColors.primaryColor),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class MobileAnimatedShowcaseItemWidget extends StatelessWidget {
  final uiShowcaseManager = sl<UiShowcaseManager>();

  MobileAnimatedShowcaseItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return CarouselSlider.builder(
      itemCount: uiShowcaseManager.showcaseItems.length,
      options: CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        aspectRatio: 9 / 16,
      ),
      itemBuilder: (context, index, __) {
        final item = uiShowcaseManager.showcaseItems[index];
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
                      children: [
                        MobileImageCarousel(item: item),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    item.projectName,
                                    textAlign: TextAlign.right,
                                    style: context.headline5!.copyWith(
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                                  Text(
                                    item.duration,
                                    textAlign: TextAlign.right,
                                    style: context.headline6!.copyWith(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: width,
                                child: Text(
                                  item.description,
                                  maxLines: 5,
                                  textAlign: TextAlign.right,
                                  style: context.bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () async {
                                  await launchUrl(Uri.parse(item.url));
                                },
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
                );
              },
            );
          },
        );
      },
    );
  }
}
