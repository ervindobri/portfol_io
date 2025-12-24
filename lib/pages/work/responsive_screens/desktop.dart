import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfol_io/constants/animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/pages/work/grid_view.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:rive/rive.dart';

class WorkDesktop extends HookConsumerWidget {
  const WorkDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final uiMenuManager = sl<UiMenuManager>();

    final currentOffset = useState(uiMenuManager.offsets[1]);
    final nextOffset = useState(uiMenuManager.offsets[2]);

    final progress = useState(0.0);
    final height = context.height;
    final parentHeight = context.height * 1.3;
    final difference = parentHeight - height;
    useEffect(() {
      currentOffset.value = uiMenuManager.offsets[1];
      nextOffset.value = uiMenuManager.offsets[2];
      listener() {
        currentOffset.value = uiMenuManager.offsets[1];
        nextOffset.value = uiMenuManager.offsets[2];

        final scrollOffset = uiMenuManager.scrollController.offset;

        // Start animation when WorkHeader (centered) reaches middle of viewport
        final animationStartOffset = currentOffset.value + difference / 2;
        // End animation earlier so it finishes with header below the menu

        const maxEffectPixels = 120;
        const speed = 1;
        // Only start animating when the Work section reaches the middle of the screen
        if (scrollOffset < animationStartOffset) {
          // Keep progress at 0 until animation should start
          progress.value = 0.0;
        } else if (scrollOffset > (currentOffset.value + height)) {
          progress.value = clampDouble(
              (1 -
                      clampDouble(
                          (scrollOffset - currentOffset.value - height) /
                              difference,
                          0.0,
                          1.0)) *
                  speed,
              0.0,
              1.0);
        } else {
          // Animation progresses from animationStartOffset to animationEndOffset
          progress.value = clampDouble(
              clampDouble(
                      (scrollOffset - animationStartOffset) / maxEffectPixels,
                      0.0,
                      1.0) *
                  speed,
              0.0,
              1.0);
        }
      }

      uiMenuManager.scrollController.addListener(listener);
      return () => uiMenuManager.scrollController.removeListener(listener);
    }, [uiMenuManager.scrollController.offset]);


    void scrollToTop() {
      uiMenuManager.scrollController.animateTo(
        currentOffset.value + difference - kToolbarHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }


    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        width: Globals.maxBoxWidth,
      ),
      child: SizedBox(
        height: parentHeight, // Increased height for spacing
        width: width,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Background Elements: These "appear" from behind as we scroll
            Positioned.fill(
              child: Opacity(
                opacity: progress.value,
                child: Padding(
                  padding: EdgeInsets.only(top: parentHeight - height),
                  child: Transform.translate(
                    offset: Offset(
                        0, lerpDouble(context.height / 4, 0, progress.value)!),
                    child: Transform.scale(
                      scale:
                          0.9 + (0.1 * progress.value), // Slight zoom-in effect
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 64, left: 20, right: 20),
                        child: IgnorePointer(
                          ignoring: progress.value < 1.0,
                          child: const ProjectsGridView(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // The Sticky Text
            Align(
              alignment: Alignment.lerp(
                Alignment.center,
                Alignment.topLeft,
                progress.value,
              )!,
              child: GestureDetector(
                onTap: scrollToTop,
                child: Padding(
                  padding: EdgeInsets.lerp(
                      EdgeInsets.zero,
                      EdgeInsets.only(
                        top: parentHeight - height,
                        left: 0,
                      ),
                      progress.value)!,
                  child: Transform.scale(
                    scale: 1.5 - clampDouble(progress.value, 0.0, 1.0),
                    alignment: Alignment.lerp(
                        Alignment.center, Alignment.topLeft, progress.value)!,
                    child: const WorkHeader(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkHeader extends StatelessWidget {
  const WorkHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 12,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: RiveAnimation.network(
              AppAnimations.fireUrl,
              fit: BoxFit.cover,
              controllers: [SimpleAnimation('idle')],
            ),
          ),
          SelectableText(
            Globals.workTitle,
            style: context.headline1,
          ),
        ],
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
