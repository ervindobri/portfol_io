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
import 'package:portfol_io/custom_widgets/bg_shape.dart';
import 'package:portfol_io/custom_widgets/fade_in_slide.dart';
import 'package:portfol_io/custom_widgets/sliding_widget.dart';
import 'package:portfol_io/custom_widgets/social_media_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'home_section/controller/home_controller.dart';
import 'home_section/view/home_content.dart';
import 'package:portfol_io/pages/services_content.dart';
import 'package:quiver/iterables.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'footer.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
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
            NotificationListener<ScrollNotification>(
              onNotification: (scrollState) {
                if (scrollState is ScrollNotification) {
                    setState(() {
                      _selectedIndex = (scrollState.metrics.pixels/Get.height).toInt();
                    });
                }
                return false;
              },
              child: Scrollbar(
                child: Container(
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: _itemPositionListener,
                    addAutomaticKeepAlives: false,
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
                height: Get.height*.15,
                // color: ThemeUtils.darkGrey.withOpacity(.0),
                child: topMenu(),
              ),
            ),
          ),
        ],
      )
    );
  }

  topMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: Get.width*.05,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/logo1.png"
                    )
                  )
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: List.generate(Globals.menu.length, (index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: InkWell(
                          onTap: (){
                            _itemScrollController.scrollTo(index: index, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
                              setState(() {
                                _selectedIndex = index;
                                animateCurrentPage(index);
                              });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Globals.menu[index],
                                style: GoogleFonts.oswald(
                                  color: ThemeUtils.primaryColor,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 25,
                                ),
                              ),
                              if ( _selectedIndex == index)
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: ThemeUtils.primaryColor,
                                    shape: BoxShape.circle
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ThemeUtils.primaryColor),
                        shadowColor: MaterialStateProperty.all(ThemeUtils.primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))
                        )
                    ),
                    onPressed: () { print("button"); },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Globals.contactMe,
                        style: GoogleFonts.oswald(
                          color: ThemeUtils.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget sectionWidget(int i) {
      if (i == 0) {
          return new HomeContent(
          onPressedCheckMe: (){
            _itemScrollController.scrollTo(index: i+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
            setState(()=> _selectedIndex=1);
          }
      );
      } else if (i == 1) {
      return ServicesContent();
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
      homeController.reverseAnimations();

    } else if (i == 2) {
      homeController.reverseAnimations();

    } else if (i == 3) {
      homeController.reverseAnimations();

    } else if (i == 4) {
      homeController.reverseAnimations();

    } else if (i == 5) {
      homeController.reverseAnimations();

    } else if (i == 6) {
      homeController.reverseAnimations();
    }
    else{
      homeController.forwardAnimations();

    }
  }
}
