import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_content.dart';
import 'package:portfol_io/pages/home/home_content.dart';
import 'package:portfol_io/pages/menu/menu.dart';
import 'package:portfol_io/pages/work/work_content.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/jump_home_button.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
              final isMobile =
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile;
              final double mobilePadding = isMobile ? 16 : 32;
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: context.width < Globals.maxBoxWidth
                          ? const EdgeInsets.symmetric(horizontal: 24)
                          : null,
                      child: ImprovedScrolling(
                        scrollController: uiMenuManager.scrollController,
                        enableMMBScrolling: true,
                        enableCustomMouseWheelScrolling:
                            ref.watch(scrollEnabledProvider),
                        customMouseWheelScrollConfig:
                            const CustomMouseWheelScrollConfig(
                          scrollAmountMultiplier: 2.25,
                          scrollDuration: Duration(milliseconds: 300),
                          scrollCurve: Curves.linearToEaseOut,
                          mouseWheelTurnsThrottleTimeMs: 20,
                        ),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: uiMenuManager.scrollController,
                            child: _buildScrollableList(),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 8,
                      child: StickyMenu(),
                    ),
                    Positioned(
                      bottom: mobilePadding,
                      right: mobilePadding,
                      child: const JumpToHomeButton(),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildScrollableList() {
    return const Column(
      children: [
        HomeContent(),
        WorkContent(),
        ContactContent(),
      ],
    );
  }
}
