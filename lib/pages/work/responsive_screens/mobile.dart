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
  const WorkMobile._({required this.orientation});

  factory WorkMobile.portrait() =>
      const WorkMobile._(orientation: Orientation.portrait);

  factory WorkMobile.landscape() =>
      const WorkMobile._(orientation: Orientation.landscape);

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
    final isPortrait = widget.orientation == Orientation.portrait;
    final pageHeight = isPortrait ? height : width;
    return ClipRRect(
      child: ValueListenableBuilder<LayoutView>(
        valueListenable: uiShowcaseManager.showcaseView,
        builder: (context, value, _) {
          return ValueListenableBuilder<
              CommandResult<void, List<ShowcaseItem>>>(
            valueListenable: uiShowcaseManager.itemsCommand.results,
            builder: (context, items, _) {
              if (items.hasError) {
                return const SizedBox();
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
                            ValueListenableBuilder<LayoutView>(
                                valueListenable: uiShowcaseManager.showcaseView,
                                builder: (context, view, _) {
                                  return Wrap(
                                    children: [
                                      IconButton(
                                          icon: Container(
                                            color: view == LayoutView.grid
                                                ? Colors.white
                                                : null,
                                            child: Icon(
                                              CupertinoIcons.square_grid_2x2,
                                              color: view == LayoutView.grid
                                                  ? GlobalColors.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            uiShowcaseManager.showcaseView
                                                .value = LayoutView.grid;
                                          }),
                                      IconButton(
                                          icon: Container(
                                            color: view == LayoutView.single
                                                ? Colors.white
                                                : null,
                                            child: Icon(
                                              CupertinoIcons
                                                  .list_bullet_below_rectangle,
                                              color: view == LayoutView.single
                                                  ? GlobalColors.primaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            uiShowcaseManager.showcaseView
                                                .value = LayoutView.single;
                                          }),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<LayoutView>(
                          valueListenable: uiShowcaseManager.showcaseView,
                          builder: (context, view, _) {
                            switch (view) {
                              case LayoutView.grid:
                                return MobileShowcaseGridView();
                              case LayoutView.detail:
                                return const SizedBox();
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
