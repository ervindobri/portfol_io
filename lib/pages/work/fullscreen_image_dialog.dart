import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class FullscreenImageDialog extends StatelessWidget {
  FullscreenImageDialog({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ShowcaseItem item;

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            child: ValueListenableBuilder<int>(
              valueListenable: uiShowcaseManager.currentImageIndex,
              builder: (context, value, _) {
                final path =
                    "assets/images/work/${item.imagesPath}/${item.imageAssets[value]}.png";
                return InteractiveViewer(
                  alignPanAxis: true,
                  child: Center(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        path,
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
              splashColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
              icon: Container(
                height: 64,
                width: 64,
                color: GlobalColors.primaryColor,
                child: Center(
                  child:
                      Icon(CupertinoIcons.xmark, size: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            child: IconButton(
              iconSize: 48,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () =>
                  uiShowcaseManager.previousImageItemCommand.execute(),
              icon: Container(
                height: 64,
                width: 64,
                color: GlobalColors.primaryColor,
                child: Center(
                  child: Icon(CupertinoIcons.chevron_left,
                      size: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            right: 24,
            child: IconButton(
              iconSize: 48,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => uiShowcaseManager.nextImageItemCommand.execute(),
              icon: Container(
                height: 64,
                width: 64,
                color: GlobalColors.primaryColor,
                child: Center(
                  child: Icon(CupertinoIcons.chevron_right,
                      size: 24, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileFullscreenImageDialog extends StatelessWidget {
  MobileFullscreenImageDialog({
    Key? key,
    required this.item,
    required this.image,
  }) : super(key: key);

  final ShowcaseItem item;
  final String image;
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dismissible(
      key: Key('key'),
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
                  Text(
                    "Pan around and zoom with your fingers.",
                    style: context.bodyText1,
                  ),
                  const SizedBox(height: 16),
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
                                "assets/images/work/${item.imagesPath}/${item.imageAssets[value]}.png",
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
                    height: 64,
                    width: 64,
                    color: GlobalColors.primaryColor,
                    child: Center(
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
                  iconSize: 48,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () =>
                      uiShowcaseManager.previousImageItemCommand.execute(),
                  icon: Container(
                    height: 64,
                    width: 64,
                    color: GlobalColors.primaryColor,
                    child: Center(
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
                  iconSize: 48,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () =>
                      uiShowcaseManager.nextImageItemCommand.execute(),
                  icon: Container(
                    height: 64,
                    width: 64,
                    color: GlobalColors.primaryColor,
                    child: Center(
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
