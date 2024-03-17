import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/responsive_screens/showcase_item_view.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:rive/rive.dart';

class WorkDesktop extends ConsumerStatefulWidget {
  const WorkDesktop({super.key});

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
    final themeColor = ref.watch(themeColorProvider);
    final workIndex = ref.watch(workIndexProvider);
    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        Size(
          Globals.maxBoxWidth,
          context.height,
        ),
      ),
      child: ClipRRect(
        child: ValueListenableBuilder<LayoutView>(
          valueListenable: uiShowcaseManager.showcaseView,
          builder: (context, value, _) {
            return ValueListenableBuilder<
                CommandResult<void, List<ShowcaseItem>>>(
              valueListenable: uiShowcaseManager.itemsCommand.results,
              builder: (context, items, _) {
                if (items.hasError || items.data == null) {
                  return SizedBox(height: height);
                }
                final offset = Offset(workIndex.toDouble(), 0);
                const itemExtent = 32.0;
                return SizedBox(
                  // height: value == View.grid ? height + rows * 420 : height,
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      const SizedBox(height: kToolbarHeight * 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                                const SizedBox(width: 12),
                                SelectableText(
                                  Globals.workTitle,
                                  style: theme.inverseBodyLarge,
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                AnimatedSlide(
                                  offset: offset,
                                  duration: kThemeAnimationDuration,
                                  curve: Curves.easeInOut,
                                  child: AnimatedContainer(
                                    duration: kThemeAnimationDuration,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                        color: themeColor.withOpacity(.3),
                                      ),
                                      color: themeColor,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: offset,
                                          color: themeColor.withOpacity(.2),
                                          blurRadius: offset.dx * 8,
                                        )
                                      ],
                                    ),
                                    width: itemExtent,
                                    padding: const EdgeInsets.all(8),
                                    child: Opacity(
                                      opacity: 0,
                                      child: Center(
                                        child: Text(
                                          "0",
                                          style: context.bodyText2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: List.generate(
                                    items.data!.length,
                                    (index) => InkWell(
                                      splashColor: Colors.transparent,
                                      customBorder: Border.all(),
                                      // highlightColor: Colors.transparent,
                                      borderRadius: BorderRadius.circular(32),
                                      onTap: () {
                                        uiShowcaseManager.currentItemCommand
                                            .execute(index);

                                        ref
                                            .read(workIndexProvider.notifier)
                                            .update((state) => index);
                                      },
                                      child: AnimatedContainer(
                                        duration: kThemeAnimationDuration,
                                        width: itemExtent,
                                        padding: const EdgeInsets.all(8),
                                        child: AnimatedSwitcher(
                                          duration: kThemeAnimationDuration,
                                          key: ValueKey(index),
                                          transitionBuilder: (child, anim) =>
                                              ScaleTransition(
                                            scale: anim,
                                            child: child,
                                          ),
                                          child: Center(
                                            key: ValueKey(index),
                                            child: Text(
                                              (index + 1).toString(),
                                              style: context.bodyText2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Expanded(
                        child: ShowcaseItemView(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
