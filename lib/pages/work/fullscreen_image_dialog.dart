import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class MobileFullscreenImageDialog extends StatelessWidget {
  const MobileFullscreenImageDialog({
    super.key,
    required this.item,
    required this.image,
  });

  final ShowcaseItem item;
  final String image;

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final width = context.width;
    final height = context.height;
    return Dismissible(
      key: const Key('key'),
      direction: DismissDirection.vertical,
      onDismissed: (d) => Navigator.pop(context),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: uiShowcaseManager.currentImageIndex,
                    builder: (context, value, _) {
                      return AspectRatio(
                        aspectRatio: 1600 / 1200,
                        child: InteractiveViewer(
                          // minScale: .5,
                          // maxScale: 3.0,
                          child: Hero(
                            tag: image,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                item.imageAssets[value],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  iconSize: 48,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    height: 32,
                    width: 32,
                    color: context.theme.primaryColor,
                    child: const Center(
                      child: Icon(CupertinoIcons.xmark,
                          size: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: IconButton(
                  iconSize: 32,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () =>
                      uiShowcaseManager.previousImageItemCommand.execute(),
                  icon: Container(
                    height: 32,
                    width: 32,
                    color: context.theme.primaryColor,
                    child: const Center(
                      child: Icon(CupertinoIcons.chevron_left,
                          size: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: IconButton(
                  iconSize: 32,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () =>
                      uiShowcaseManager.nextImageItemCommand.execute(),
                  icon: Container(
                    height: 32,
                    width: 32,
                    color: context.theme.primaryColor,
                    child: const Center(
                      child: Icon(CupertinoIcons.chevron_right,
                          size: 24, color: Colors.white),
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
