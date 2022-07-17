import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/contact/contact_content.dart';
import 'package:portfol_io/pages/home/home_content.dart';
import 'package:portfol_io/pages/work/work_content.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:portfol_io/widgets/menu/menu_desktop.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: GlobalColors.primaryColor,
        body: Stack(
          children: [
            Container(
              child: ScrollablePositionedList.builder(
                itemScrollController: uiMenuManager.itemScrollController,
                itemPositionsListener: uiMenuManager.itemPositionListener,
                physics: PageScrollPhysics(),
                itemCount: Globals.menu.length,
                itemBuilder: (context, index) {
                  return sectionWidget(index);
                },
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 60,
                width: width,
                color: GlobalColors.primaryColor.withOpacity(.8),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48),
                    child: buildTopMenu(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 48,
              right: 48,
              child: ValueListenableBuilder(
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
                                    color:
                                        GlobalColors.lightGrey.withOpacity(.12),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Icon(FontAwesomeIcons.chevronUp,
                                          color: Colors.white),
                                    )),
                              ),
                            ),
                    );
                  }),
            ),
          ],
        ));
  }

  // DEsktop top menu
  buildTopMenu() {
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
      mobile: SizedBox(),
      tablet: SizedBox(),
      desktop: MenuDesktop(),
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

  void animateCurrentPage(int i) {
    if (i == 0) {
      // animationManager.forwardAnimations();
      print("Animating home page!");
    } else if (i == 1) {
      // animationManager.reverseAnimations();
    } else if (i == 2) {
      // animationManager.reverseAnimations();
    } else if (i == 3) {
      // animationManager.reverseAnimations();
    } else if (i == 4) {
      // animationManager.reverseAnimations();
    } else if (i == 5) {
      // animationManager.reverseAnimations();
    } else if (i == 6) {
      // animationManager.reverseAnimations();
    } else {
      // animationManager.forwardAnimations();
    }
  }
}
