import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
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
                  return AspectRatio(
                    aspectRatio: 1600 / 1200,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/work/${item.imagesPath}/${item.imageAssets[value]}.png"),
                    ),
                  );
                }),
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
