import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/responsive_screens/desktop.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_gridview.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
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
    final imageSize = width / 3;
    return ClipRRect(
      child: ValueListenableBuilder<View>(
          valueListenable: uiShowcaseManager.showcaseView,
          builder: (context, value, _) {
            return ValueListenableBuilder<
                    CommandResult<void, List<ShowcaseItem>>>(
                valueListenable: uiShowcaseManager.itemsCommand.results,
                builder: (context, items, _) {
                  final rows = items.data!.length / 2 - 1;
                  return SizedBox(
                      height: value == View.grid ? height + rows * 420 : height,
                      width: width,
                      child: Stack(
                        // alignment: Alignment.center,
                        children: [
                          //BG Blobs
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
                                filter:
                                    ImageFilter.blur(sigmaX: 96, sigmaY: 96),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.0)),
                                ),
                              ),
                            ),
                          ),
                          //Content
                          SizedBox(
                            width: width,
                            // height: height,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  24, 24 + 42, 24, 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          Globals.showcase,
                                          style: context.bodyText1!.copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      ValueListenableBuilder<View>(
                                          valueListenable:
                                              uiShowcaseManager.showcaseView,
                                          builder: (context, view, _) {
                                            return Wrap(
                                              children: [
                                                IconButton(
                                                    icon: Container(
                                                      color: view == View.grid
                                                          ? Colors.white
                                                          : null,
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .square_grid_2x2,
                                                        color: view == View.grid
                                                            ? GlobalColors
                                                                .primaryColor
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      uiShowcaseManager
                                                          .showcaseView
                                                          .value = View.grid;
                                                    }),
                                                IconButton(
                                                    icon: Container(
                                                      color: view == View.single
                                                          ? Colors.white
                                                          : null,
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .list_bullet_below_rectangle,
                                                        color: view ==
                                                                View.single
                                                            ? GlobalColors
                                                                .primaryColor
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      uiShowcaseManager
                                                          .showcaseView
                                                          .value = View.single;
                                                    }),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  ValueListenableBuilder<View>(
                                      valueListenable:
                                          uiShowcaseManager.showcaseView,
                                      builder: (context, view, _) {
                                        switch (view) {
                                          case View.grid:
                                            return Expanded(
                                              child: ShowcaseGridView(),
                                            );
                                          case View.detail:
                                            return SizedBox();
                                          default:
                                            return MobileShowcaseItemView();
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                });
          }),
    );
  }
}
