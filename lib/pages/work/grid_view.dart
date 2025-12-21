import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work_details/work_details.dart';
import 'package:portfol_io/widgets/widgets.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsGridView extends HookWidget {
  const ProjectsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final animate = useState(false);
    return VisibilityDetector(
      key: const ValueKey('projects'),
      onVisibilityChanged: (visible) {
        animate.value = visible.visibleFraction > 0.2;
      },
      child: ValueListenableBuilder<List<ShowcaseItem>>(
        valueListenable: uiShowcaseManager.showcaseItems,
        builder: (context, value, __) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              if (index >= value.length) {
                return const PlaceholderGridItem();
              }
              final item = value[index];
              return FadeIn(
                animate: animate.value,
                delay: Duration(
                  milliseconds: 50 * index,
                ),
                child: WorkGridItem(
                  item: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PlaceholderGridItem extends StatelessWidget {
  const PlaceholderGridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.theme.inverseTextColor,
        ),
      ),
    );
  }
}

class WorkGridItem extends StatelessWidget {
  const WorkGridItem({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    return HoverWidget(builder: (context, hovering) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: kThemeAnimationDuration,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  scale: hovering ? 1.1 : 1.0,
                  image: AssetImage(
                    item.imageAssets.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IgnorePointer(
              ignoring: !hovering,
              child: ProAnimatedBlur(
                duration: kThemeAnimationDuration,
                blur: hovering ? 16 : 0,
                child: AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: hovering ? 1 : 0,
                  child: Container(
                    width: context.width,
                    color: context.theme.containerColor.withAlpha(128),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 24,
                      children: [
                        SlideInUp(
                          animate: hovering,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.projectName,
                              maxLines: 2,
                              style: context.headline5,
                            ),
                          ),
                        ),
                        SlideInUp(
                          delay: const Duration(
                            milliseconds: 50,
                          ),
                          duration: const Duration(milliseconds: 200),
                          animate: hovering,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: context.theme.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorkDetailsScreen(item: item),
                                ),
                              );
                            },
                            child: Row(
                              spacing: 12,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "See details",
                                  style: context.bodyText1,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: context.theme.inverseTextColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
