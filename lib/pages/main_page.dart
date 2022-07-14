import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/manager/menu_manager.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_section/work_content.dart';
import 'home_section/home/home_content.dart';
import 'package:portfol_io/pages/home_section/services_content.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'footer.dart';
import 'home_section/menu/menu_desktop.dart';
import 'home_section/menu/menu_tablet.dart';

// ignore: must_be_immutable
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
      return ServicesContent();
    } else if (i == 3) {
      return ServicesContent();
    } else if (i == 4) {
      return ServicesContent();
    } else if (i == 5) {
      return SizedBox(
        height: 40.0,
      );
    } else if (i == 6) {
      // return ArrowOnTop(
      // onPressed: () => _scroll(0),
      // );
      return Container();
    } else if (i == 7) {
      return Footer();
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
