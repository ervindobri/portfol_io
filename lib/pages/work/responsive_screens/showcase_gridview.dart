import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/grid_showcase_card.dart';

class ShowcaseGridView extends StatelessWidget {
  ShowcaseGridView({Key? key}) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final crossAxisCount = 2;
    // final cardWidth = width / crossAxisCount;
    return ValueListenableBuilder<CommandResult<void, List<ShowcaseItem>?>>(
        valueListenable: uiShowcaseManager.itemsCommand.results,
        builder: (context, value, _) {
          final items = value.data;
          if (items == null) {
            return SizedBox();
          }
          return Column(
            children: [
              Expanded(
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1200 / 1600,
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
                            child: ShowcaseCard(item: item, index: index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: items.length <= uiShowcaseManager.showcaseItems.length,
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

class MobileShowcaseGridView extends StatelessWidget {
  MobileShowcaseGridView({Key? key}) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: ValueListenableBuilder<CommandResult<void, List<ShowcaseItem>?>>(
          valueListenable: uiShowcaseManager.itemsCommand.results,
          builder: (context, value, _) {
            final items = value.data;
            if (items == null) {
              return SizedBox();
            }
            print("Items: $items");
            return SizedBox(
              // height: height * .75,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: items.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 300),
                        child: SlideAnimation(
                          verticalOffset: -50,
                          child: FadeInAnimation(
                            child: MobileShowcaseCard(item: item, index: index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}


// Visibility(
              //   visible: items.length <= uiShowcaseManager.showcaseItems.length,
              //   child: Center(
              //     child: TextButton(
              //       onPressed: () => uiShowcaseManager.showMoreItems(),
              //       child: Text("Show more".toUpperCase(),
              //           style: context.bodyText1),
              //     ),
              //   ),
              // ),