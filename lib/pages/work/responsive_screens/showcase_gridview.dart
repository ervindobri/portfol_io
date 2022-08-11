import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowcaseGridView extends StatelessWidget {
  ShowcaseGridView({Key? key}) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final crossAxisCount = 3;
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

class ShowcaseCard extends StatefulWidget {
  final ShowcaseItem item;
  // final double width;
  final int index;
  ShowcaseCard({Key? key, required this.item, this.index = 0})
      : super(key: key);

  @override
  State<ShowcaseCard> createState() => _ShowcaseCardState();
}

class _ShowcaseCardState extends State<ShowcaseCard> {
  ValueNotifier<bool> showImageOverlay = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final image = widget.item.imageAssets.first;
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MouseRegion(
      onEnter: (event) {
        setState(() => showImageOverlay.value = true);
      },
      onExit: (event) {
        setState(() => showImageOverlay.value = false);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/work/${widget.item.imagesPath}/$image.png"),
                fit: BoxFit.cover),
          )),
          ValueListenableBuilder<bool>(
            valueListenable: showImageOverlay,
            builder: (context, showImageOverlay, _) {
              return AnimatedOpacity(
                duration: kThemeAnimationDuration,
                opacity: showImageOverlay ? 1.0 : 0.0,
                child: InkWell(
                  onTap: () {
                    sl<UiShowcaseManager>()
                        .currentItemCommand
                        .execute(widget.index);
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(.9),
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: SizedBox(
                          height: height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                  height: height * .75,
                                  child: AnimatedShowcaseItemWidget()),
                              Positioned(
                                top: 0,
                                child: IconButton(
                                  iconSize: 42,
                                  onPressed: () => Navigator.pop(context),
                                  icon: Center(
                                    child: Icon(CupertinoIcons.xmark, size: 42),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: GlobalColors.primaryColor.withOpacity(.8),
                    child: Center(
                      child: Wrap(
                        spacing: 32,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.item.projectName,
                                style: context.bodyText1?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 24,
                                ),
                              ),
                              // Icon(CupertinoIcons),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            children: widget.item.tags
                                .map(
                                  (e) => Text(
                                    "#${e.toLowerCase()}",
                                    style: context.bodyText2
                                        ?.copyWith(fontWeight: FontWeight.w100),
                                  ),
                                )
                                .toList(),
                          ),
                          TextButton(
                              onPressed: () => launchUrlString(widget.item.url),
                              child: Container(
                                  color: Colors.white,
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                  child: Text(
                                    Globals.checkItOut,
                                    style: context.headline5?.copyWith(
                                        color: GlobalColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
