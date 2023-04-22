import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/providers/providers.dart';

class WorkDesktop extends ConsumerStatefulWidget {
  const WorkDesktop({Key? key}) : super(key: key);

  @override
  ConsumerState<WorkDesktop> createState() => _WorkDesktopState();
}

class _WorkDesktopState extends ConsumerState<WorkDesktop> {
  final uiMenuManager = sl<UiMenuManager>();
  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeProvider);
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
              return SizedBox(
                // height: value == View.grid ? height + rows * 420 : height,
                height: height,
                width: width,
                child: Column(
                  children: [
                    const SizedBox(height: kToolbarHeight * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured projects",
                            style: theme.inverseBodyLarge,
                          ),
                          Text(
                            "See All",
                            style: theme.inverseBodyLarge?.copyWith(
                              color: ref.watch(themeColorProvider),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Expanded(
                      child: ShowcaseItemView(),
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
