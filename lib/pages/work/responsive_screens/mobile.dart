import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
import 'package:portfol_io/injection_manager.dart';

enum Orientation { portrait, landscape }

class WorkMobile extends StatefulWidget {
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
  State<WorkMobile> createState() => _WorkMobileState();
}

class _WorkMobileState extends State<WorkMobile> {
  final uiMenuManager = sl<UiMenuManager>();
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // If we have an item, show details instead of the grid
    if (widget.item != null) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: context.topPadding + kToolbarHeight),
          child: Column(
            children: [
              Text(widget.item!.projectName),
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
                        Text(
                          Globals.featuredProjects,
                          style: context.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  const MobileShowcaseItemView(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
