import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowcaseCard extends StatefulWidget {
  final ShowcaseItem item;
  // final double width;
  final int index;
  const ShowcaseCard({super.key, required this.item, this.index = 0});

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
                    "assets/images/work/${widget.item.imagesPath}/$image"),
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
                      barrierColor: Colors.black.withAlpha(230),
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: SizedBox(
                          height: height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // SizedBox(
                              //     height: height * .75,
                              //     child: AnimatedShowcaseItemWidget()),
                              Positioned(
                                top: 0,
                                child: IconButton(
                                  iconSize: 42,
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Center(
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
                    color: GlobalColors.primaryColor.withAlpha(204),
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

class MobileShowcaseCard extends StatefulWidget {
  final ShowcaseItem item;
  // final double width;
  final int index;
  const MobileShowcaseCard({super.key, required this.item, this.index = 0});

  @override
  State<MobileShowcaseCard> createState() => _MobileShowcaseCardState();
}

class _MobileShowcaseCardState extends State<MobileShowcaseCard> {
  ValueNotifier<bool> showImageOverlay = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final image = widget.item.imageAssets.first;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        setState(() => showImageOverlay.value = !showImageOverlay.value);
      },
      child: SizedBox(
        width: width,
        height: height / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InkWell(
              child: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/work/${widget.item.imagesPath}/$image",
                  ),
                  fit: BoxFit.cover,
                ),
              )),
            ),
            InkWell(
              onTap: () {
                setState(
                    () => showImageOverlay.value = !showImageOverlay.value);
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: showImageOverlay,
                builder: (context, showImageOverlay, _) {
                  if (!showImageOverlay) {
                    return const SizedBox();
                  }
                  return AnimatedOpacity(
                    duration: kThemeAnimationDuration,
                    opacity: showImageOverlay ? 1.0 : 0.0,
                    child: Container(
                      color: GlobalColors.primaryColor.withAlpha(204),
                      padding: const EdgeInsets.all(20),
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierColor: Colors.black.withAlpha(230),
                                builder: (_) => Dismissible(
                                  direction: DismissDirection.vertical,
                                  key: const Key('key'),
                                  onDismissed: (_) =>
                                      Navigator.of(context).pop(),
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    child: SizedBox(
                                      height: height,
                                      width: width,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: height,
                                            child:
                                                MobileAnimatedShowcaseItemView(
                                                    item: widget.item),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: IconButton(
                                              iconSize: 42,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: const Center(
                                                child: Icon(
                                                  CupertinoIcons.xmark,
                                                  size: 42,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              widget.item.projectName,
                              style: context.bodyText1?.copyWith(
                                fontWeight: FontWeight.w100,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            children: widget.item.tags
                                .map(
                                  (e) => Text(
                                    "#${e.toLowerCase()}",
                                    style: context.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => launchUrlString(widget.item.url),
                            style: GlobalStyles.whiteTextButtonStyle(),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Text(
                                Globals.checkItOut,
                                style: context.headline5?.copyWith(
                                    color: GlobalColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
