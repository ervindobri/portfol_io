import 'dart:math';

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
import 'package:portfol_io/pages/home_section/controller/home_controller.dart';

class HomeContent extends StatefulWidget {
  final VoidCallback onPressedCheckMe;

  const HomeContent({Key? key, required this.onPressedCheckMe}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  num _titleAnimOffset = Get.height - 100;
  ScrollController _scrollController = ScrollController();
  HomeController homeController = Get.put(HomeController())!;
  var random = new Random();


  @override
  Widget build(BuildContext context) {
    return homeContents();
  }
  homeContents() {
    return GetBuilder(
      init: homeController,
      builder: (controller){
        return Container(
            height: Get.height,
            width: Get.width,
            child:Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [ ThemeUtils.bezier1, ThemeUtils.bezier3],
                          end: Alignment.topLeft,
                          begin: Alignment.bottomRight
                      )
                  ),
                  child: SlidingWidget(
                    offset: Offset(-.2, 0.0),
                    animation: homeController.delayedAnimations[3],
                    child: BackgroundShape(
                      offset: Offset(250, 200),
                      colors: [ ThemeUtils.bezier1, ThemeUtils.bezier1],
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
                    colors: [ ThemeUtils.bezier1, ThemeUtils.bezier2],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                SlidingWidget(
                  offset: Offset(-.6, 0.0),
                  animation: homeController.delayedAnimations[0],
                  child: BackgroundShape(
                    offset: Offset(-200, -50),
                    colors: [ ThemeUtils.bezier1, ThemeUtils.darkGrey],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: FadeTransition(
                          opacity: Tween<double>(
                            begin: 0,
                            end: 1,
                          ).animate(homeController.titleAnimation),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, 0.1),
                              end: Offset.zero,
                            ).animate(homeController.titleAnimation),
                            child: Text(
                              Globals.homeTitle,
                              style: GoogleFonts.oswald(
                                  color: ThemeUtils.white,
                                  fontSize: Get.width/15,
                                  shadows: [BoxShadow(
                                      color: ThemeUtils.darkGrey,
                                      blurRadius: 10,
                                      spreadRadius: -2
                                  )]
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadingSlideWidget(
                          animation: homeController.titleAnimation,
                          offset: Offset(0, 0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 200),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width*.15,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(ThemeUtils.primaryColor),
                                        shadowColor: MaterialStateProperty.all(ThemeUtils.primaryColor),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15))
                                        )
                                    ),
                                    onPressed: () {
                                      widget.onPressedCheckMe();
                                      homeController.reverseAnimations();

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            Globals.checkMeOut,
                                            style: GoogleFonts.oswald(
                                              color: ThemeUtils.white,
                                              fontSize: 30,
                                            ),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.arrowDown,
                                            color: ThemeUtils.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: List.generate(Globals.socialMediaBubbles.values.length, (index)
                                    => SlidingWidget(
                                      offset: Offset(-10,0),
                                      animation: homeController.delayedAnimations[index],
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SocialMediaBubble(
                                            icon: Globals.socialMediaBubbles.values.toList()[index].first,
                                            href: Globals.socialMediaBubbles.values.toList()[index].last
                                        ),
                                      ),
                                    )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 100,
                  child: Container(
                    height: Get.height/2.2,
                    width: Get.width*.4,
                    // color: Colors.black,
                    child: ParallaxStack(
                      layers: [
                        ParallaxLayer(
                          yRotation: 0.35,
                          xOffset: 10,
                          xRotation: .3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              greyButton(1, "Logo design", (){ print("hi"); }),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  greyButton(0, "UX/UI design", () { }),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: ThemeUtils.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage("assets/pic.jpeg"),
                                                  fit: BoxFit.cover
                                              ),
                                              shape: BoxShape.circle
                                          )
                                      ),
                                    ),
                                  ),
                                  greyButton(3, "Desktop s", () { }),
                                ],
                              ),
                              greyButton(2, "Mobile Apps", () { }),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
        );
      },

    );
  }
  greyButton(int index, String title, VoidCallback onTap) {
    return FadingSlideWidget(
      animation: homeController.buttonAnimations[index],
      offset: Offset(index%2==0 ? -(random.nextInt(10) + 1)/10 : (random.nextInt(10) + 1)/10, 0),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ThemeUtils.lightGrey),
              shadowColor: MaterialStateProperty.all(ThemeUtils.lightGrey),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))
              )
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.oswald(
                  color: ThemeUtils.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 25
              ),
            ),
          ),
        ),
      ),
    );
  }
}
