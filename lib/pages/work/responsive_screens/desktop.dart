import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_gridview.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
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
    return ClipRRect(
      child: ValueListenableBuilder<View>(
        valueListenable: uiShowcaseManager.showcaseView,
        builder: (context, value, _) {
          return ValueListenableBuilder<
              CommandResult<void, List<ShowcaseItem>>>(
            valueListenable: uiShowcaseManager.itemsCommand.results,
            builder: (context, items, _) {
              if (items.hasError || items.data == null) {
                return SizedBox(height: height);
              }
              final rows = items.data!.length / 3 - 1;
              return SizedBox(
                // height: value == View.grid ? height + rows * 420 : height,
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SizedBox(
                        //       child: Text(
                        //         Globals.showcase,
                        //         style: context.headline6!
                        //             .copyWith(color: Colors.white),
                        //       ),
                        //     ),
                        //     ValueListenableBuilder<View>(
                        //       valueListenable: uiShowcaseManager.showcaseView,
                        //       builder: (context, view, _) {
                        //         return Wrap(
                        //           children: [
                        //             IconButton(
                        //                 icon: Container(
                        //                   color: view == View.grid
                        //                       ? Colors.white
                        //                       : null,
                        //                   child: Icon(
                        //                     CupertinoIcons.square_grid_2x2,
                        //                     color: view == View.grid
                        //                         ? GlobalColors.primaryColor
                        //                         : Colors.white,
                        //                   ),
                        //                 ),
                        //                 onPressed: () {
                        //                   uiShowcaseManager.showcaseView.value =
                        //                       View.grid;
                        //                 }),
                        //             IconButton(
                        //               icon: Container(
                        //                 color: view == View.single
                        //                     ? Colors.white
                        //                     : null,
                        //                 child: Icon(
                        //                   CupertinoIcons
                        //                       .list_bullet_below_rectangle,
                        //                   color: view == View.single
                        //                       ? GlobalColors.primaryColor
                        //                       : Colors.white,
                        //                 ),
                        //               ),
                        //               onPressed: () {
                        //                 uiShowcaseManager.showcaseView.value =
                        //                     View.single;
                        //               },
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 16),
                        ValueListenableBuilder<View>(
                          valueListenable: uiShowcaseManager.showcaseView,
                          builder: (context, view, _) {
                            switch (view) {
                              case View.grid:
                                return Expanded(
                                  child: ShowcaseGridView(),
                                );
                              case View.detail:
                                return SizedBox();
                              default:
                                return ShowcaseItemView();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
