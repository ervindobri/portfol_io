import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';

class HoverImage extends StatefulWidget {
  final String image;
  final ShowcaseItem item;

  const HoverImage({super.key, required this.image, required this.item});

  @override
  HoverImageState createState() => HoverImageState();
}

class HoverImageState extends State<HoverImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation padding;
  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
          reverseCurve: Curves.easeOut),
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width / 2,
      height: height / 2,
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            _controller.forward();
            uiShowcaseManager.showImageOverlay.value = true;
          });
        },
        onExit: (value) {
          setState(() {
            _controller.reverse();
            uiShowcaseManager.showImageOverlay.value = false;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..scale(_animation.value, _animation.value),
              child: Image.asset(
                "assets/images/work/${widget.item.imagesPath}/${widget.image}.png",
                fit: BoxFit.contain,
                cacheWidth: width ~/ 2,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: !uiShowcaseManager.showImageOverlay.value
                    ? const SizedBox()
                    : FittedBox(
                        child: TextButton(
                          child: Container(
                            color: GlobalColors.darkGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.expand,
                                      color: Colors.white, size: 32),
                                  const SizedBox(width: 16),
                                  Text('Expand', style: context.bodyText1),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            final imageIndex =
                                widget.item.imageAssets.indexOf(widget.image);
                            uiShowcaseManager.currentImageIndex.value =
                                imageIndex;
                            showDialog(
                              context: context,
                              barrierColor:
                                  GlobalColors.primaryColor.withOpacity(.8),
                              builder: (context) {
                                return FullscreenImageDialog(item: widget.item);
                              },
                            );
                          },
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
