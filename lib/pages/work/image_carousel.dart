import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';

class ImageCarousel extends StatelessWidget {
  ImageCarousel({
    Key? key,
    required this.item,
  }) : super(key: key);

  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();
  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<int>(
      valueListenable: uiShowcaseManager.currentImageIndex,
      builder: (_, value, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              key: Key(item.imageAssets[value]),
              duration: const Duration(milliseconds: 300),
              builder: (_, double value2, anim) {
                final image = item.imageAssets[value];
                return MouseRegion(
                  onEnter: (event) {
                    uiShowcaseManager.showImageOverlay.value = true;
                  },
                  onExit: (event) {
                    uiShowcaseManager.showImageOverlay.value = false;
                  },
                  child: Opacity(
                    opacity: value2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          width: width,
                          height: height,
                          child: Image(
                            // color: Colors.black,
                            fit: BoxFit.contain,
                            image: AssetImage(
                                "assets/images/work/${item.imagesPath}/$image.png"),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: uiShowcaseManager.showImageOverlay,
                          builder: (context, showImageOverlay, _) {
                            return AnimatedOpacity(
                              duration: kThemeAnimationDuration,
                              opacity: showImageOverlay ? 1.0 : 0.0,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: GlobalColors.primaryColor
                                        .withOpacity(.8),
                                    builder: (context) {
                                      return FullscreenImageDialog(
                                          item: item);
                                    },
                                  );
                                },
                                child: Container(
                                  color:
                                      GlobalColors.primaryColor.withOpacity(.8),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 16,
                                      children: [
                                        FaIcon(FontAwesomeIcons.expand,
                                            color: Colors.white),
                                        Text(
                                          Globals.clickToExpand,
                                          style: context.headline6?.copyWith(
                                              fontWeight: FontWeight.w100),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: item.imageAssets.map((entry) {
                  final index = item.imageAssets.indexOf(entry);
                  return InkWell(
                    onTap: () {
                      uiShowcaseManager.setImageCommand.execute(index);
                    },
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : GlobalColors.primaryColor)
                                  .withOpacity(value == index ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (item.imageAssets.length > 1)
              Positioned(
                top: 12,
                child: Row(
                  children: [
                    IconButton(
                      splashColor: Colors.white,
                      iconSize: 24,
                      onPressed: () {
                        //prev. image
                        uiShowcaseManager.previousImageItemCommand.execute();
                      },
                      icon: Container(
                        color: Colors.white,
                        child: Icon(
                          CupertinoIcons.chevron_left,
                          color: GlobalColors.primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.white,
                      iconSize: 24,
                      onPressed: () {
                        //next. image
                        uiShowcaseManager.nextImageItemCommand.execute();
                      },
                      icon: Container(
                        color: Colors.white,
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          color: GlobalColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}

class MobileImageCarousel extends StatelessWidget {
  MobileImageCarousel({
    Key? key,
    required this.item,
  }) : super(key: key);

  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();
  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<int>(
      valueListenable: uiShowcaseManager.currentImageIndex,
      builder: (_, value, __) {
        return Container(
          width: width,
          height: height * .3,
          color: GlobalColors.primaryColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: item.imageAssets.length,
                options: CarouselOptions(
                  aspectRatio: 16 / 12,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    uiShowcaseManager.setImageCommand.execute(index);
                  },
                ),
                itemBuilder: (context, index, what) {
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    key: Key(item.imageAssets[index]),
                    duration: const Duration(milliseconds: 300),
                    builder: (_, double value2, anim) {
                      final image = item.imageAssets[index];
                      return Opacity(
                        opacity: value2,
                        child: Container(
                          width: width,
                          height: height,
                          child: Image(
                            // color: Colors.black,
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/work/${item.imagesPath}/$image.png"),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: item.imageAssets.map((entry) {
                    final index = item.imageAssets.indexOf(entry);
                    return InkWell(
                      onTap: () {
                        uiShowcaseManager.setImageCommand.execute(index);
                      },
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : GlobalColors.primaryColor)
                                    .withOpacity(value == index ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
