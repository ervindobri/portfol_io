import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_content.dart';
import 'package:portfol_io/pages/menu/home_content.dart';
import 'package:portfol_io/pages/menu/menu.dart';
import 'package:portfol_io/pages/work/work_content.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  void dispose() {
    uiMenuManager.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previousColor =
        ref.watch(previousBrightnessProvider).extBackgroundColor;
    final nextColor = ref.watch(themeProvider).brightness.extBackgroundColor;

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: previousColor, end: nextColor),
      duration: const Duration(milliseconds: 50),
      builder: (_, color, __) {
        return Scaffold(
          backgroundColor: color,
          resizeToAvoidBottomInset: true,
          body: ResponsiveBuilder(builder: (context, sizingInformation) {
            final isMobile =
                sizingInformation.deviceScreenType == DeviceScreenType.mobile;
            final double mobilePadding = isMobile ? 0 : 32;
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: isMobile
                        ? EdgeInsets.symmetric(horizontal: mobilePadding)
                        : context.width < Globals.maxBoxWidth
                            ? const EdgeInsets.symmetric(horizontal: 24)
                            : null,
                    child: WebSmoothScroll(
                      controller: uiMenuManager.scrollController,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          controller: uiMenuManager.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            width: context.width,
                            child: Column(
                              children: [
                                ...[
                                  const HomeContent(),
                                  const WorkContent(),
                                  const ContactContent(),
                                ].mapIndexed(
                                  (index, page) => VisibilityDetector(
                                    key: uiMenuManager.itemKeys.value[index],
                                    onVisibilityChanged: (visibility) {
                                      if (visibility.visibleFraction >
                                          0.489999) {
                                        uiMenuManager.setVisiblePage(index);
                                      }
                                    },
                                    child: page,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: isMobile ? 0 : context.topPadding,
                    child: const StickyMenu(),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
