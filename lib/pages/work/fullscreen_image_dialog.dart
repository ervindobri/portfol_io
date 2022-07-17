import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class FullscreenImageDialog extends StatelessWidget {
  const FullscreenImageDialog({
    Key? key,
    required this.item,
    required this.image,
  }) : super(key: key);

  final ShowcaseItem item;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          SizedBox(
            child: AspectRatio(
              aspectRatio: 1600 / 1200,
              child: Hero(
                tag: image,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      "assets/images/work/${item.imagesPath}/$image.png"),
                ),
              ),
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
        ],
      ),
    );
  }
}
