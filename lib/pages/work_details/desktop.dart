import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/models/showcase_item.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:portfol_io/pages/work/grid_view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class WorkDetailsDesktop extends HookWidget {
  const WorkDetailsDesktop({
    super.key,
    required this.item,
    this.isMobile = false,
  });

  final ShowcaseItem item;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: context.bodyText1!,
          child: Padding(
            padding: isMobile
                ? const EdgeInsets.symmetric(horizontal: 16.0)
                : EdgeInsets.zero,
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: Globals.maxBoxWidth,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: AppBar(
                      surfaceTintColor: context.backgroundColor,
                      centerTitle: false,
                      backgroundColor: context.backgroundColor,
                      scrolledUnderElevation: 0,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      actions: [
                        if (item.figmaLink != null)
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              launchUrlString(item.figmaLink!);
                            },
                            label: const Text('Figma'),
                            icon: SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: Image.asset(
                                  AppIcons.figma,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                      ],
                      title: Text(
                        item.projectName,
                        style: isMobile ? context.bodyText1 : context.headline2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: WebSmoothScroll(
                    controller: scrollController,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                            width: Globals.maxBoxWidth,
                          ),
                          child: SelectableRegion(
                            selectionControls: MaterialTextSelectionControls(),
                            child: Column(
                              spacing: 48,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: isMobile
                                      ? context.width
                                      : context.width * .5,
                                  child: Text(
                                    item.description,
                                    style: context.bodyText2?.copyWith(
                                      height: 2,
                                      fontSize: 24,
                                      fontFamily: Globals.fontFamilyPlayfair,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                if (item.tags.isNotEmpty)
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      ...item.tags.mapIndexed(
                                        (index, item) => FadeInRight(
                                          duration: Globals.durationFast,
                                          delay: Duration(
                                              milliseconds: index * 50),
                                          child: Chip(
                                            side: BorderSide.none,
                                            backgroundColor:
                                                context.theme.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusGeometry.circular(
                                                      666),
                                            ),
                                            label: Text(item),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                Column(
                                  spacing: 24,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Roles",
                                      style: context.bodyText2?.copyWith(
                                        height: 2,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    DefaultTextStyle(
                                      style: context.bodyText2!.copyWith(
                                        fontFamily: Globals.fontFamilyPlayfair,
                                      ),
                                      child: Column(
                                        spacing: 12,
                                        children: [
                                          ...item.roles.mapIndexed(
                                            (index, item) => FadeInLeftBig(
                                              duration: Globals.durationFast,
                                              delay: Duration(
                                                  milliseconds:
                                                      500 + index * 100),
                                              child: Row(
                                                spacing: 8,
                                                children: [
                                                  const Icon(Icons
                                                      .arrow_forward_sharp),
                                                  Flexible(
                                                    child: Text(
                                                      item,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (item.publishedAppStoreUrl != null ||
                                    item.publishedGooglePlayUrl != null)
                                  Row(
                                    spacing: 24,
                                    children: [
                                      Text("Store links",
                                          style: context.headline3),
                                      Text(
                                        "No store links available yet",
                                        style: context.bodyText2?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      Row(
                                        spacing: 12,
                                        children: [
                                          if (item.publishedAppStoreUrl != null)
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                backgroundColor:
                                                    context.theme.primaryColor,
                                              ),
                                              onPressed: () {
                                                launchUrlString(
                                                    item.publishedAppStoreUrl!);
                                              },
                                              icon: SvgPicture.asset(
                                                AppIcons.appStore,
                                              ),
                                            ),
                                          if (item.publishedGooglePlayUrl !=
                                              null)
                                            IconButton(
                                              style: IconButton.styleFrom(
                                                backgroundColor:
                                                    context.theme.primaryColor,
                                              ),
                                              onPressed: () {
                                                launchUrlString(item
                                                    .publishedGooglePlayUrl!);
                                              },
                                              icon: SvgPicture.asset(
                                                AppIcons.playStore,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 24,
                                  children: [
                                    Text("Project gallery",
                                        style: context.headline5),
                                    StaggeredGrid.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 24,
                                      crossAxisSpacing: 24,
                                      children: item.images.map(
                                        (image) {
                                          return InkWell(
                                            onTap: () async {
                                              final imageIndex =
                                                  item.images.indexOf(image);
                                              sl<UiShowcaseManager>()
                                                  .currentImageIndex
                                                  .value = imageIndex;
                                              Navigator.push(
                                                context,
                                                AnimatedPageRoute(
                                                  child: Scaffold(
                                                    body: FullscreenImageDialog(
                                                      item: item,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: image,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.asset(
                                                  image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ],
                                ),
                                const Text("That's it for now."),
                                const SizedBox(
                                  height: 48,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
