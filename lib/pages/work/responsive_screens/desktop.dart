import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/grid_view.dart';
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
    final workIndex = ref.watch(workIndexProvider);
    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        Size(
          Globals.maxBoxWidth,
          context.height,
        ),
      ),
      child: ClipRRect(
        child: SizedBox(
                  // height: value == View.grid ? height + rows * 420 : height,
                  height: height,
                  width: width,
                  child: Column(
            spacing: 24,
                    children: [
              const SizedBox(height: kToolbarHeight),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                      spacing: 12,
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
                                SelectableText(
                                  Globals.workTitle,
                          style: context.headline5,
                                ),
                              ],
                            ),
                    // AnimatedNumberIndicator(
                    //   offset: offset,
                    //   itemExtent: itemExtent,
                    //   length: items.data!.length,
                    //   onItemTap: (index) {
                    //     uiShowcaseManager.currentItemCommand
                    //         .execute(index);

                    //     ref
                    //         .read(workIndexProvider.notifier)
                    //         .update((state) => index);
                    //   },
                    // ),
                  ],
                ),
              ),
              const ProjectsGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedNumberIndicator extends ConsumerWidget {
  const AnimatedNumberIndicator({
    super.key,
    required this.offset,
    required this.itemExtent,
    required this.length,
    required this.onItemTap,
  });

  final Offset offset;
  final double itemExtent;
  final int length;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    return Stack(
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
                color: themeColor.withAlpha(78),
              ),
              color: themeColor,
              boxShadow: [
                BoxShadow(
                  offset: offset,
                  color: themeColor.withAlpha(52),
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
            length,
            (index) => InkWell(
              splashColor: Colors.transparent,
              customBorder: Border.all(),
              // highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(32),
              onTap: () => onItemTap(index),
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                width: itemExtent,
                padding: const EdgeInsets.all(8),
                child: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  key: ValueKey(index),
                  transitionBuilder: (child, anim) => ScaleTransition(
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
    );
  }
}
