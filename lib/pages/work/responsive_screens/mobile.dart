import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:portfol_io/injection_manager.dart';

class WorkMobile extends StatefulWidget {
  WorkMobile({Key? key}) : super(key: key);

  @override
  State<WorkMobile> createState() => _WorkMobileState();
}

class _WorkMobileState extends State<WorkMobile> {
  final uiMenuManager = sl<UiMenuManager>();
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    return ClipRRect(
      child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //BG Blobs
              Positioned(
                left: 0,
                top: 24,
                child: Container(
                  height: imageSize / 2,
                  width: imageSize / 2,
                  decoration: BoxDecoration(
                    // color: ThemeUtils.green.withOpacity(.4),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/blob2.png",
                        ),
                        opacity: .4),
                    color: Colors.white,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 48,
                top: 48,
                child: Container(
                  height: imageSize,
                  width: imageSize,
                  decoration: BoxDecoration(
                    // color: ThemeUtils.green.withOpacity(.4),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/blob1.png",
                      ),
                      opacity: .4,
                    ),
                    // color: Colors.red,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 96, sigmaY: 96),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
              ),
              //Content
              SizedBox(
                width: width,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(48, 48 + 60, 48, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          Globals.showcase,
                          style:
                              context.headline6!.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: width,
                        height: height * .8 - 96 - 32 - 32,
                        // color: GlobalColors.lightGrey.withOpacity(.4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: AnimatedShowcaseItemWidget(),
                        ),
                      ),
                      SizedBox(height: 16),
                      CarouselController(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}