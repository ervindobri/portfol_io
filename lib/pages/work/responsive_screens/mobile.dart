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

enum Orientation { portrait, landscape }

class WorkMobile extends StatefulWidget {
  final Orientation orientation;
  WorkMobile._({Key? key, required this.orientation}) : super(key: key);

  factory WorkMobile.portrait() =>
      WorkMobile._(orientation: Orientation.portrait);

  factory WorkMobile.landscape() =>
      WorkMobile._(orientation: Orientation.landscape);

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
    final imageSize = width;
    final isPortrait = widget.orientation == Orientation.portrait;
    final pageHeight = isPortrait ? height : width;
    return ClipRRect(
      child: ValueListenableBuilder<View>(
        valueListenable: uiShowcaseManager.showcaseView,
        builder: (context, value, _) {
          return ValueListenableBuilder<
              CommandResult<void, List<ShowcaseItem>>>(
            valueListenable: uiShowcaseManager.itemsCommand.results,
            builder: (context, items, _) {
              if (items.hasError) {
                return SizedBox();
              }
              // final rows = items.data!.length / 2 - 1;
              return SizedBox(
                height: pageHeight,
                width: width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24 + 32, 0, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Globals.showcase,
                              style: context.bodyText2?.copyWith(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            ValueListenableBuilder<View>(
                                valueListenable: uiShowcaseManager.showcaseView,
                                builder: (context, view, _) {
                                  return Wrap(
                                    children: [
                                      IconButton(
                                          icon: Container(
                                            color: view == View.grid
                                                ? Colors.white
                                                : null,
                                            child: Icon(
                                              CupertinoIcons.square_grid_2x2,
                                              color: view == View.grid
                                                  ? GlobalColors.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            uiShowcaseManager
                                                .showcaseView.value = View.grid;
                                          }),
                                      IconButton(
                                          icon: Container(
                                            color: view == View.single
                                                ? Colors.white
                                                : null,
                                            child: Icon(
                                              CupertinoIcons
                                                  .list_bullet_below_rectangle,
                                              color: view == View.single
                                                  ? GlobalColors.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            uiShowcaseManager.showcaseView
                                                .value = View.single;
                                          }),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ValueListenableBuilder<View>(
                          valueListenable: uiShowcaseManager.showcaseView,
                          builder: (context, view, _) {
                            switch (view) {
                              case View.grid:
                                return MobileShowcaseGridView();
                              case View.detail:
                                return SizedBox();
                              default:
                                return MobileShowcaseItemView();
                            }
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
