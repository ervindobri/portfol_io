import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/bumble_scrollbar.dart';

class ImageView extends ConsumerStatefulWidget {
  const ImageView({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  ConsumerState<ImageView> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends ConsumerState<ImageView> {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
        right: Radius.circular(48),
      ),
      child: Stack(
        children: [
          MouseRegion(
            onEnter: (val) {
              // Disable main page scrolling
              ref.read(scrollEnabledProvider.notifier).update((state) => false);
            },
            onExit: (val) {
              // Enable main page scrolling
              ref.read(scrollEnabledProvider.notifier).update((state) => true);
            },
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ImprovedScrolling(
                scrollController: _controller,
                enableCustomMouseWheelScrolling: true,
                enableKeyboardScrolling: true,
                keyboardScrollConfig: const KeyboardScrollConfig(),
                child: SingleChildScrollView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...widget.item.imageAssets.map(
                          (e) => Image.asset(
                            "assets/images/work/${widget.item.imagesPath}/$e.png",
                            // height: height,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Scrollbar
          Positioned(
            right: 24,
            top: 24,
            child: BumbleScrollbar.web(
              controller: _controller,
              thumbColor: theme.inverseTextColor,
              thumbHeight: 200 / widget.item.imageAssets.length,
            ),
          ),
        ],
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
                          child: SizedBox(
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
