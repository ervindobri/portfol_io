import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:portfol_io/injection_manager.dart';

class WorkDesktop extends StatefulWidget {
  WorkDesktop({Key? key}) : super(key: key);

  @override
  State<WorkDesktop> createState() => _WorkDesktopState();
}

class _WorkDesktopState extends State<WorkDesktop> {
  final uiMenuManager = sl<UiMenuManager>();
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    return ClipRRect(
      child: ValueListenableBuilder<View>(
          valueListenable: uiShowcaseManager.showcaseView,
          builder: (context, value, _) {
            return ValueListenableBuilder<
                    CommandResult<void, List<ShowcaseItem>>>(
                valueListenable: uiShowcaseManager.itemsCommand.results,
                builder: (context, items, _) {
                  final rows = items.data!.length / 3 - 1;
                  return SizedBox(
                      height: value == View.grid ? height + rows * 420 : height,
                      width: width,
                      child: Stack(
                        // alignment: Alignment.center,
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
                                filter:
                                    ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.0)),
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
                                  48, 48 + 60, 48, 48),
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
                                          style: context.headline6!
                                              .copyWith(color: Colors.white),
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
                                            return Column(
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: height * .8 -
                                                      96 -
                                                      32 -
                                                      32,
                                                  // color: GlobalColors.lightGrey.withOpacity(.4),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0),
                                                    child:
                                                        AnimatedShowcaseItemWidget(),
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                CarouselController(),
                                              ],
                                            );
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

class ShowcaseGridView extends StatelessWidget {
  ShowcaseGridView({Key? key}) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = 3;
    final cardWidth = width / crossAxisCount;
    return ValueListenableBuilder<CommandResult<void, List<ShowcaseItem>>>(
        valueListenable: uiShowcaseManager.itemsCommand.results,
        builder: (context, value, _) {
          final items = value.data as List<ShowcaseItem>;
          print(items);
          return Column(
            children: [
              Expanded(
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1600 / 1200,
                      crossAxisSpacing: 24,
                      // mainAxisExtent: cardWidth,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 3,
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 300),
                        child: SlideAnimation(
                          verticalOffset: -50,
                          child: FadeInAnimation(
                            child: ShowcaseCard(item: item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: items.length <= showcaseItems.length,
                child: Center(
                  child: TextButton(
                    onPressed: () => uiShowcaseManager.showMoreItems(),
                    child: Text("Show more".toUpperCase(),
                        style: context.bodyText1),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ShowcaseCard extends StatelessWidget {
  final ShowcaseItem item;
  // final double width;
  const ShowcaseCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = item.imageAssets.first;

    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/work/${item.imagesPath}/$image.png"),
          fit: BoxFit.cover),
    ));
  }
}
