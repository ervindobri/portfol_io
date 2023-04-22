import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:portfol_io/providers/providers.dart';

class ImageView extends ConsumerStatefulWidget {
  const ImageView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ShowcaseItem item;

  @override
  ConsumerState<ImageView> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends ConsumerState<ImageView> {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();
  final ScrollController _controller = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _scrollOffset = _controller.offset;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = ref.watch(themeProvider);
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(48),
      ),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.item.imageAssets.length,
              itemBuilder: (_, index) => Image.asset(
                "assets/images/work/${widget.item.imagesPath}/${widget.item.imageAssets[index]}.png",
              ),
            ),
          ),
          Positioned(
            right: 24,
            top: 24,
            child: Stack(
              children: [
                Container(
                  width: 24,
                  height: 24 * 10,
                  decoration: BoxDecoration(
                    color: theme.extBackgroundColor.withOpacity(.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                AnimatedPositioned(
                  top: _scrollOffset,
                  duration: const Duration(milliseconds: 10),
                  child: Container(
                    width: 24,
                    height:
                        (24 * 10) / (widget.item.imageAssets.length).toDouble(),
                    decoration: BoxDecoration(
                      color: theme.inverseTextColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                        child: InkWell(
                          onTap: () {
                            //TODO: open interactive image viewer for current image
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MobileFullscreenImageDialog(
                                  item: item,
                                  image: image,
                                );
                              },
                            );
                          },
                          child: Container(
                            width: width,
                            height: height,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/work/${item.imagesPath}/$image.png",
                              ),
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
