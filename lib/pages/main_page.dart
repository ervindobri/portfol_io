import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/controller/home_controller.dart';
import 'package:portfol_io/custom_widgets/bg_shape.dart';
import 'package:portfol_io/custom_widgets/sliding_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_section/aboutme_contet.dart';
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
  int _selectedIndex = 0;

  ScrollController _scrollController = ScrollController();
  ItemScrollController _itemScrollController = ItemScrollController();
  ItemPositionsListener _itemPositionListener = ItemPositionsListener.create();

  HomeController homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ThemeUtils.bezier1, ThemeUtils.bezier3],
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight)),
          child: SlidingWidget(
            offset: Offset(-.2, 0.0),
            animation: homeController.delayedAnimations[3],
            child: BackgroundShape(
              offset: Offset(250, 200),
              colors: [ThemeUtils.bezier1, ThemeUtils.bezier1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SlidingWidget(
          offset: Offset(-.4, 0.0),
          animation: homeController.delayedAnimations[2],
          child: BackgroundShape(
            offset: Offset(-50, 100),
            colors: [ThemeUtils.bezier1, ThemeUtils.bezier2],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        SlidingWidget(
          offset: Offset(-.6, 0.0),
          animation: homeController.delayedAnimations[0],
          child: BackgroundShape(
            offset: Offset(-200, -50),
            colors: [ThemeUtils.bezier1, ThemeUtils.darkGrey],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        NotificationListener<ScrollNotification>(
          onNotification: (scrollState) {
            if (scrollState is ScrollNotification) {
              setState(() {
                _selectedIndex = scrollState.metrics.pixels ~/ Get.height;
              });
            }
            return false;
          },
          child: Scrollbar(
            child: Container(
              child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionListener,
                // addAutomaticKeepAlives: false,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: Globals.menu.length,
                itemBuilder: (context, index) {
                  return sectionWidget(index);
                },
              ),
            ),
          ),
        ),
        Positioned(
          child: ClipRRect(
            child: Container(
              height: Get.height * .15,
              // color: ThemeUtils.darkGrey.withOpacity(.0),
              child: topMenu(),
            ),
          ),
        ),
      ],
    ));
  }

  // DEsktop top menu
  topMenu() {
    return ScreenTypeLayout(
      breakpoints: ScreenBreakpoints(tablet: 666, desktop: 1000, watch: 300),
      mobile: MenuDesktop(selectedIndex: _selectedIndex),
      tablet: MenuTablet(
        selectedIndex: _selectedIndex,
        onItemTapCallback: (index) {
          print("Tapped!");
          _itemScrollController.scrollTo(
              index: index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCirc);
          setState(() {
            animateCurrentPage(index);
          });
        },
      ),
      desktop: MenuDesktop(selectedIndex: _selectedIndex),
    );
  }

  Widget sectionWidget(int i) {
    if (i == 0) {
      return new HomeContent(onPressedCheckMe: () {
        _itemScrollController.scrollTo(
            index: i + 1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCirc);
        setState(() => _selectedIndex = 1);
      });
    } else if (i == 1) {
      return AboutMeContent();
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
      homeController.forwardAnimations();
      print("Animating home page!");
    } else if (i == 1) {
      // homeController.reverseAnimations();
    } else if (i == 2) {
      // homeController.reverseAnimations();
    } else if (i == 3) {
      // homeController.reverseAnimations();
    } else if (i == 4) {
      // homeController.reverseAnimations();
    } else if (i == 5) {
      // homeController.reverseAnimations();
    } else if (i == 6) {
      // homeController.reverseAnimations();
    } else {
      // homeController.forwardAnimations();
    }
  }
}
