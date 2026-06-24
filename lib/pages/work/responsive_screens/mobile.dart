import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:portfol_io/constants/animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/models/showcase_item.dart';
import 'package:portfol_io/pages/work/grid_view.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:rive/rive.dart';

enum Orientation { portrait, landscape }

enum ViewType { grid, single }

class WorkMobile extends HookWidget {
  final Orientation orientation;
  final ShowcaseItem? item;

  const WorkMobile._({
    required this.orientation,
    this.item,
  });

  factory WorkMobile.portrait({ShowcaseItem? item}) =>
      WorkMobile._(orientation: Orientation.portrait, item: item);

  factory WorkMobile.landscape({ShowcaseItem? item}) =>
      WorkMobile._(orientation: Orientation.landscape, item: item);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final uiShowcaseManager = sl<UiShowcaseManager>();

    final viewType = useState(ViewType.single);

    // If we have an item, show details instead of the grid
    if (item != null) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: context.topPadding + kToolbarHeight),
          child: Column(
            children: [
              Text(item!.projectName),
              const Expanded(child: Placeholder()),
            ],
          ),
        ),
      );
    }

    // Original grid view logic
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.only(top: context.topPadding + kToolbarHeight),
        child: ClipRRect(
          child:
              ValueListenableBuilder<CommandResult<void, List<ShowcaseItem>>>(
            valueListenable: uiShowcaseManager.itemsCommand.results,
            builder: (context, items, _) {
              if (items.hasError) {
                return const SizedBox();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: RiveAnimation.network(
                                AppAnimations.fireUrl,
                                fit: BoxFit.cover,
                                controllers: [SimpleAnimation('idle')],
                              ),
                            ),
                            Text(
                              Globals.featuredProjects,
                              style: context.bodyText1,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            // switch view to grid
                            viewType.value = viewType.value == ViewType.grid
                                ? ViewType.single
                                : ViewType.grid;
                          },
                          icon: const Icon(
                            CupertinoIcons.square_grid_2x2,
                          ),
                        )
                      ],
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: viewType.value == ViewType.grid
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: ProjectsGridView.mobile(),
                          )
                        : const MobileShowcaseItemView(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
