import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_content.dart';
import 'package:portfol_io/pages/home/home_content.dart';
import 'package:portfol_io/pages/menu/menu.dart';
import 'package:portfol_io/pages/work/work_content.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalColors.primaryColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ResponsiveBuilder(builder: (context, sizingInformation) {
          final isMobile =
              sizingInformation.deviceScreenType == DeviceScreenType.mobile;
          final double mobilePadding = isMobile ? 16 : 32;

          return Stack(
            children: [
              SizedBox(
                height: height,
                child: ScrollablePositionedList.builder(
                  shrinkWrap: true,
                  itemScrollController: uiMenuManager.itemScrollController,
                  itemPositionsListener: uiMenuManager.itemPositionListener,
                  semanticChildCount: 3,
                  initialScrollIndex: 0,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: Globals.menu.length,
                  itemBuilder: (context, index) {
                    return sectionWidget(index);
                  },
                ),
              ),
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       sectionWidget(0),
              //       Container(color: Colors.black, height: height),
              //       Container(color: Colors.white, height: height),
              //       // sectionWidget(1),
              //       // sectionWidget(2),
              //     ],
              //   ),
              // ),
              Positioned(
                top: 0,
                // duration: Duration(milliseconds: 300),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                    child: StickyMenu(),
                  ),
                ),
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
  }

  Widget sectionWidget(int i) {
    if (i == 0) {
      return new HomeContent();
    } else if (i == 1) {
      return WorkContent();
    } else if (i == 2) {
      return ContactContent();
    } else {
      return Container();
    }
  }
}

class JumpToHomeButton extends StatelessWidget {
  JumpToHomeButton({
    Key? key,
  }) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      final isMobile =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile;
      if (!isMobile) {
        return ValueListenableBuilder(
          valueListenable: uiMenuManager.menuIndex,
          builder: (context, int value, __) {
            return AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              child: value < 1
                  ? SizedBox()
                  : FadingSlideWidget(
                      offset: Offset(0, 2),
                      child: TextButton(
                        style: GlobalStyles.iconButtonStyle(),
                        onPressed: () =>
                            uiMenuManager.updateMenuCommand.execute(0),
                        child: Container(
                          color: GlobalColors.lightGrey.withOpacity(.12),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Icon(FontAwesomeIcons.chevronUp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            );
          },
        );
      }
      return ValueListenableBuilder(
        valueListenable: uiMenuManager.menuIndex,
        builder: (context, int value, __) {
          return AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: value < 1
                ? SizedBox()
                : FadingSlideWidget(
                    offset: Offset(0, 2),
                    durationMilliseconds: 300,
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () =>
                          uiMenuManager.updateMenuCommand.execute(0),
                      iconSize: isMobile ? 42 : 64,
                      icon: Container(
                        padding: EdgeInsets.all(isMobile ? 8.0 : 16),
                        color: GlobalColors.primaryColor.withOpacity(.4),
                        child: Center(
                          child: Icon(FontAwesomeIcons.chevronUp,
                              size: isMobile ? 32 : 42, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          );
        },
      );
    });
  }
}
