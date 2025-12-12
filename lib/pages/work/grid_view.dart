import 'package:flutter/material.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class ProjectsGridView extends StatelessWidget {
  const ProjectsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final items = uiShowcaseManager.showcaseItems.value;
    return ValueListenableBuilder<List<ShowcaseItem>>(
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
            final item = value[index];
            return Container(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                    item.imageAssets.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }
    );
  }
}
