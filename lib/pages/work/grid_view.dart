import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work_details/work_details.dart';
import 'package:portfol_io/widgets/widgets.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class ProjectsGridView extends HookWidget {
  const ProjectsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    return ValueListenableBuilder<List<ShowcaseItem>>(
      valueListenable: uiShowcaseManager.showcaseItems,
      builder: (context, value, __) {
        return GridView.custom(
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(2, 2),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: 9,
            (context, index) {
              if (index < value.length) {
                return WorkGridItem(item: value[index]);
              }
              return const PlaceholderGridItem();
            },
          ),
        );
      },
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
    return HoverWidget(
      builder: (context, hovering) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              AnimatedScale(
                scale: hovering ? 1.5 : 1.0,
                duration: kThemeAnimationDuration,
                child: AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  decoration: BoxDecoration(
                    color: context.theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      scale: hovering ? 1.5 : 1.0,
                      image: AssetImage(
                        item.images.first,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: !hovering,
                child: ProAnimatedBlur(
                  duration: kThemeAnimationDuration,
                  blur: hovering ? 4 : 0,
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
                                if (kDebugMode) {
                                  print("navigating to details");
                                }
                                Navigator.push(
                                  context,
                                  AnimatedPageRoute(
                                    child: WorkDetailsScreen(
                                      item: item,
                                    ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedPageRoute extends PageRouteBuilder {
  AnimatedPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  final Widget child;
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.99, end: 1.0).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
