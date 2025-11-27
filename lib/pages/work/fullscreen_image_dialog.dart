import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/providers/providers.dart';

class FullscreenImageDialog extends ConsumerWidget {
  FullscreenImageDialog({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          child: ValueListenableBuilder<int>(
            valueListenable: uiShowcaseManager.currentImageIndex,
            builder: (context, value, _) {
              final path = item.imageAssets[value];
              return InteractiveViewer(
                panAxis: PanAxis.aligned,
                child: Hero(
                  tag: path,
                  child: Center(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        path,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 24,
          right: 24,
          child: IconButton(
            iconSize: 48,
            highlightColor: Colors.transparent,
            color: context.backgroundColor,
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            icon: const Center(
              child: Icon(CupertinoIcons.xmark, size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          left: 24,
          child: IconButton(
            iconSize: 48,
            style: IconButton.styleFrom(backgroundColor: themeColor),
            onPressed: () =>
                uiShowcaseManager.previousImageItemCommand.execute(),
            icon: const Center(
              child: Icon(CupertinoIcons.chevron_left,
                  size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          right: 24,
          child: IconButton(
            iconSize: 48,
            style: IconButton.styleFrom(backgroundColor: themeColor),
            onPressed: () => uiShowcaseManager.nextImageItemCommand.execute(),
            icon: const Center(
              child: Icon(CupertinoIcons.chevron_right,
                  size: 24, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileFullscreenImageDialog extends HookWidget {
  const MobileFullscreenImageDialog({
    super.key,
    required this.item,
    required this.image,
  });

  final ShowcaseItem item;
  final String image;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final width = context.width;
    final height = context.height;
    final images = item.imageAssets;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            spacing: 12,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.projectName, style: context.bodyText1),
                    IconButton(
                      iconSize: 48,
                      highlightColor: Colors.transparent,
                      style: IconButton.styleFrom(
                        backgroundColor: context.theme.primaryColor,
                      ),
                      splashColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context),
                      icon: const SizedBox(
                        height: 24,
                        width: 24,
                        child: Center(
                          child: Icon(CupertinoIcons.xmark,
                              size: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 9 / 16,
                child: RawScrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  thickness: 10,
                  thumbColor: context.theme.primaryColor,
                  trackColor: context.theme.primaryColor.withAlpha(100),
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Row(
                      children: images
                          .map((image) => InteractiveViewer(
                                scaleEnabled: true,
                                minScale: 0.3,
                                scaleFactor: 1.0,
                                maxScale: 3,
                                child: SizedBox(
                                  height: height,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(image),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
