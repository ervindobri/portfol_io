import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class ShowcaseGridView extends StatelessWidget {
  ShowcaseGridView({Key? key}) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = 3;
    final cardWidth = width / crossAxisCount;
    return ValueListenableBuilder<CommandResult<void, List<ShowcaseItem>>>(
        valueListenable: uiShowcaseManager.itemsCommand.results,
        builder: (context, value, _) {
          final items = value.data as List<ShowcaseItem>;
          print(items);
          return Column(
            children: [
              Expanded(
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1600 / 1200,
                      crossAxisSpacing: 24,
                      // mainAxisExtent: cardWidth,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 3,
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 300),
                        child: SlideAnimation(
                          verticalOffset: -50,
                          child: FadeInAnimation(
                            child: ShowcaseCard(item: item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: items.length <= showcaseItems.length,
                child: Center(
                  child: TextButton(
                    onPressed: () => uiShowcaseManager.showMoreItems(),
                    child: Text("Show more".toUpperCase(),
                        style: context.bodyText1),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ShowcaseCard extends StatelessWidget {
  final ShowcaseItem item;
  // final double width;
  const ShowcaseCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = item.imageAssets.first;

    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/work/${item.imagesPath}/$image.png"),
          fit: BoxFit.cover),
    ));
  }
}