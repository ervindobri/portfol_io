import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:portfol_io/pages/work/hover_image.dart';
import 'package:portfol_io/widgets/delayed_display.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();

  double _currentPage = 0.0;

  @override
  void initState() {
    uiShowcaseManager.carouselController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    uiShowcaseManager.carouselController.removeListener(_scrollListener);

    super.dispose();
  }

  _scrollListener() {
    setState(() {
      _currentPage = uiShowcaseManager.carouselController.page ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: ValueListenableBuilder<int>(
        valueListenable: uiShowcaseManager.currentImageIndex,
        builder: (_, value, __) {
          return DelayedDisplay(
            slidingBeginOffset: const Offset(-1, 0),
            slidingCurve: Curves.easeOutExpo,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: height,
                  child: PageView.builder(
                    controller: uiShowcaseManager.carouselController,
                    scrollDirection: Axis.vertical,
                    // pageSnapping: true,
                    // itemCount: widget.item.imageAssets.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final image = widget.item.imageAssets[
                          (index) % (widget.item.imageAssets.length)];

                      final result = _currentPage - index;
                      final value = -0.8 * result + 1;
                      final opacity = value.clamp(0.0, 1.0);
                      // print("$index: $result | scale:$value");
                      return ClipRect(
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(0.0, height / 2 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                            opacity: opacity,
                            child: SizedBox(
                              width: width / 2,
                              // height: height / 2,
                              // color: Colors.black,
                              child: ClipRect(
                                child:
                                    HoverImage(image: image, item: widget.item),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.item.imageAssets.map((entry) {
                      final index = widget.item.imageAssets.indexOf(entry);
                      return InkWell(
                        onTap: () {
                          uiShowcaseManager.setImageCommand.execute(index);
                        },
                        child: AnimatedContainer(
                          width: value == index ? 8 : 4.0,
                          height: 4.0,
                          duration: kThemeAnimationDuration,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : GlobalColors.primaryColor)
                                    .withOpacity(value == index ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (widget.item.imageAssets.length > 1)
                  Positioned(
                    right: 12,
                    child: Column(
                      children: [
                        IconButton(
                          splashColor: Colors.white,
                          iconSize: 24,
                          onPressed: () {
                            //prev. image
                            uiShowcaseManager.carouselController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                            uiShowcaseManager.previousImageItemCommand
                                .execute();
                          },
                          icon: Container(
                            color: Colors.white,
                            child: const Icon(
                              CupertinoIcons.chevron_up,
                              color: GlobalColors.primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.white,
                          iconSize: 24,
                          onPressed: () {
                            //next. image
                            uiShowcaseManager.carouselController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                            uiShowcaseManager.nextImageItemCommand.execute();
                          },
                          icon: Container(
                            color: Colors.white,
                            child: const Icon(
                              CupertinoIcons.chevron_down,
                              color: GlobalColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

class MobileImageCarousel extends StatelessWidget {
  MobileImageCarousel({
    super.key,
    required this.item,
  });

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
                        child: InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return MobileFullscreenImageDialog(
                                    item: item, image: image);
                              },
                            );
                          },
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(image),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                bottom: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: item.imageAssets.map((entry) {
                    final index = item.imageAssets.indexOf(entry);
                    return InkWell(
                      onTap: () {
                        uiShowcaseManager.setImageCommand.execute(index);
                      },
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(
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
