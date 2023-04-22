import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_content.dart';
import 'package:portfol_io/pages/home/home_content.dart';
import 'package:portfol_io/pages/menu/menu.dart';
import 'package:portfol_io/pages/work/work_content.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_icon_button.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  void initState() {
    // Initialize scrolling
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final height = MediaQuery.of(context).size.height;
    final previousColor =
        ref.watch(previousBrightnessProvider).extBackgroundColor;
    final nextColor = ref.watch(themeProvider).brightness.extBackgroundColor;

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      uiMenuManager.setOffsets();
    });
    return TweenAnimationBuilder<Color?>(
        tween: ColorTween(begin: previousColor, end: nextColor),
        duration: const Duration(milliseconds: 50),
        builder: (_, Color? color, __) {
          // <-- Colo
          return Scaffold(
            backgroundColor: color,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: ResponsiveBuilder(builder: (context, sizingInformation) {
                final isMobile = sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile;
                final double mobilePadding = isMobile ? 16 : 32;
                return Stack(
                  children: [
                    SizedBox(
                      height: height,
                      child: WebSmoothScroll(
                        controller: uiMenuManager.scrollController,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: uiMenuManager.scrollController,
                          child: _buildScrollableList(),
                        ),
                      ),
                      // child: ScrollablePositionedList.builder(
                      //   shrinkWrap: true,
                      //   itemScrollController:
                      //       uiMenuManager.itemScrollController,
                      //   itemPositionsListener:
                      //       uiMenuManager.itemPositionListener,
                      //   physics: const AlwaysScrollableScrollPhysics(),
                      //   itemCount: Globals.menu.length,
                      //   itemBuilder: (context, index) {
                      //     return sectionWidget(index);
                      //   },
                      // ),
                    ),
                    const Positioned(
                      top: 0,
                      child: StickyMenu(),
                    ),
                    Positioned(
                      bottom: mobilePadding,
                      right: mobilePadding,
                      child: JumpToHomeButton(),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }

  Widget sectionWidget(int i) {
    if (i == 0) {
      return const HomeContent();
    } else if (i == 1) {
      return WorkContent();
    } else if (i == 2) {
      return ContactContent();
    } else {
      return const SizedBox();
    }
  }

  _buildScrollableList() {
    return Column(
      children: [
        sectionWidget(0),
        sectionWidget(1),
        sectionWidget(2),
      ],
    );
  }
}

class JumpToHomeButton extends ConsumerWidget {
  JumpToHomeButton({
    Key? key,
  }) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuIndex = ref.watch(menuIndexProvider);
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      final isMobile =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile;
      if (!isMobile) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: menuIndex < 1
              ? const SizedBox()
              : DelayedDisplay(
                  slidingBeginOffset: const Offset(0, 2),
                  fadingDuration: kThemeAnimationDuration,
                  child: AnimatedIconButton(
                    onPressed: () {
                      uiMenuManager.updateMenuCommand.execute(0);
                      ref.read(menuIndexProvider.notifier).state = 0;
                    },
                    icon: const Icon(
                      FontAwesomeIcons.chevronUp,
                      color: Colors.white,
                    ),
                  ),
                ),
        );
      }
      return AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: menuIndex < 1
            ? const SizedBox()
            : FadingSlideWidget(
                offset: const Offset(0, 2),
                durationMilliseconds: 300,
                child: AnimatedIconButton(
                  onPressed: () {
                    uiMenuManager.updateMenuCommand.execute(0);
                    ref.read(menuIndexProvider.notifier).state = 0;
                  },
                  icon: const Icon(
                    FontAwesomeIcons.chevronUp,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
      );
    });
  }
}
