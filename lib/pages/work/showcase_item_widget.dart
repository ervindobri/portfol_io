import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedShowcaseItemWidget extends StatelessWidget {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();

  AnimatedShowcaseItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem>>(
        valueListenable: uiShowcaseManager.currentItemCommand.results,
        builder: (context, value, __) {
          final item = value.data!;
          return TweenAnimationBuilder(
              key: Key(item.projectName),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              builder: (context, double value, _) {
                return TweenAnimationBuilder(
                    key: Key(item.projectName),
                    tween: Tween<double>(begin: 25.0, end: 0.0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, double value2, _) {
                      return Transform.translate(
                        offset: Offset(0, value2),
                        child: Opacity(
                          opacity: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ImageCarousel(item: item),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.projectName,
                                      textAlign: TextAlign.right,
                                      style: context.headline4!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      item.duration,
                                      textAlign: TextAlign.right,
                                      style: context.headline6!.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 24),
                                    SizedBox(
                                      width: width / 3,
                                      child: Text(
                                        item.description,
                                        maxLines: 5,
                                        textAlign: TextAlign.right,
                                        style: context.bodyText1!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                        onPressed: () async {
                                          await launchUrl(Uri.parse(item.url));
                                        },
                                        child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.fromLTRB(
                                                24, 12, 24, 12),
                                            child: Text(
                                              Globals.checkItOut,
                                              style: context.headline6!
                                                  .copyWith(
                                                      color: GlobalColors
                                                          .primaryColor),
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}

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
          return Column(
            children: [
              Expanded(
                child: MouseRegion(
                  onEnter: (event) {
                    uiShowcaseManager.showImageOverlay.value = true;
                  },
                  onExit: (event) {
                    uiShowcaseManager.showImageOverlay.value = false;
                  },
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    key: Key(item.imageAssets[value]),
                    duration: const Duration(milliseconds: 300),
                    builder: (_, double value2, anim) {
                      final image = item.imageAssets[value];
                      return Opacity(
                        opacity: value2,
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              SizedBox(
                                width: width,
                                height: height,
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/work/${item.imagesPath}/$image.png"),
                                ),
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable:
                                    uiShowcaseManager.showImageOverlay,
                                builder: (context, showImageOverlay, _) {
                                  return AnimatedOpacity(
                                    duration: kThemeAnimationDuration,
                                    opacity: showImageOverlay ? 1.0 : 0.0,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierColor: GlobalColors
                                              .primaryColor
                                              .withOpacity(.8),
                                          builder: (context) {
                                            return FullscreenImageDialog(
                                                item: item, image: image);
                                          },
                                        );
                                      },
                                      child: Container(
                                        color: GlobalColors.primaryColor
                                            .withOpacity(.8),
                                        child: Center(
                                          child: Wrap(
                                            spacing: 16,
                                            children: [
                                              FaIcon(FontAwesomeIcons.expand,
                                                  color: Colors.white),
                                              Text(
                                                Globals.clickToExpand,
                                                style: context.headline6
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w100),
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
                ),
              ),
              Row(
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
            ],
          );
        });
  }
}
