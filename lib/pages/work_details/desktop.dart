import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/fullscreen_image_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class WorkDetailsDesktop extends HookWidget {
  const WorkDetailsDesktop({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(
              Globals.maxBoxWidth,
              context.height * 3,
            ),
          ),
          child: DefaultTextStyle(
            style: context.bodyText1!,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: AppBar(
                    surfaceTintColor: Colors.transparent,
                    centerTitle: false,
                    scrolledUnderElevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    title: Text(
                      item.projectName,
                      style: context.headline2,
                    ),
                  ),
                ),
                Expanded(
                  child: WebSmoothScroll(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      child: SelectableRegion(
                        selectionControls: MaterialTextSelectionControls(),
                        child: Column(
                          spacing: 48,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.duration,
                              style: context.bodyText2,
                            ),
                            Text(
                              item.description,
                              style: context.bodyText2?.copyWith(
                                height: 2,
                                fontSize: 24,
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            if (item.tags.isNotEmpty)
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ...item.tags.map(
                                    (item) => Chip(
                                      side: BorderSide.none,
                                      backgroundColor:
                                          context.theme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(666),
                                      ),
                                      label: Text(item),
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
                                    fontFamily: 'Playfair Display',
                                  ),
                                  child: Column(
                                    spacing: 12,
                                    children: [
                                      ...item.roles.map(
                                        (item) => Row(
                                          spacing: 8,
                                          children: [
                                            const Icon(
                                                Icons.arrow_forward_sharp),
                                            Text(item),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 24,
                              children: [
                                Text("Store links", style: context.headline3),
                                if (item.publishedAppStoreUrl == null &&
                                    item.publishedGooglePlayUrl == null)
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
                                    if (item.publishedGooglePlayUrl != null)
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              context.theme.primaryColor,
                                        ),
                                        onPressed: () {
                                          launchUrlString(
                                              item.publishedGooglePlayUrl!);
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
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 24,
                                    childAspectRatio: 16 / 12,
                                    crossAxisSpacing: 24,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    final image = item.images[index];
                                    return InkWell(
                                      onTap: () async {
                                        final imageIndex =
                                            item.images.indexOf(image);
                                        sl<UiShowcaseManager>()
                                            .currentImageIndex
                                            .value = imageIndex;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Scaffold(
                                                body: FullscreenImageDialog(
                                                  item: item,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: image,
                                        child: Image.asset(
                                          item.images[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: item.images.length,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
