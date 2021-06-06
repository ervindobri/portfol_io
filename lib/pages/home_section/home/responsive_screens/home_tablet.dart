import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/controller/home_controller.dart';
import 'package:portfol_io/custom_widgets/fade_in_slide.dart';
import 'package:portfol_io/custom_widgets/parallax_menu.dart';
import 'package:portfol_io/custom_widgets/sliding_widget.dart';
import 'package:portfol_io/custom_widgets/social_media_button.dart';

class HomeTablet extends StatefulWidget {
  HomeTablet({
    Key? key,
    required this.onPressedCheckMe,
  }) : super(key: key);

  final VoidCallback onPressedCheckMe;

  @override
  _HomeTabletState createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("TABLET"),
              Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: Get.width / 2,
                  height: Get.height / 2,
                  color: Colors.black26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadingSlideWidget(
                        animation: homeController.titleAnimation,
                        offset: Offset(0, 0.1),
                        child: AutoSizeText(
                          Globals.homeTitle,
                          maxFontSize: 70,
                          minFontSize: 50,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeUtils.white,
                          ),
                        ),
                      ),
                      FadingSlideWidget(
                          animation: homeController.titleAnimation,
                          offset: Offset(0, 0.1),
                          child: Column(
                            children: [
                              Container(
                                // width: Get.width * .15,
                                child: Center(
                                  child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ThemeUtils.primaryColor),
                                        shadowColor: MaterialStateProperty.all(
                                            ThemeUtils.primaryColor),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15)))),
                                    onPressed: () {
                                      widget.onPressedCheckMe();
                                      homeController.reverseAnimations();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              Globals.checkMeOut,
                                              minFontSize: 10,
                                              maxFontSize: 25,
                                              style: TextStyle(
                                                color: ThemeUtils.white,
                                                // fontSize: 30,
                                              ),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.arrowDown,
                                              color: ThemeUtils.white,
                                              size: Get.width / 50,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      Globals.socialMediaBubbles.values.length,
                                      (index) => SlidingWidget(
                                            offset: Offset(-10, 0),
                                            animation: homeController
                                                .delayedAnimations[index],
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: SocialMediaBubble(
                                                  icon: Globals
                                                      .socialMediaBubbles.values
                                                      .toList()[index]
                                                      .first,
                                                  href: Globals
                                                      .socialMediaBubbles.values
                                                      .toList()[index]
                                                      .last),
                                            ),
                                          )),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              ParallaxMenu()
            ],
          ),
        ));
  }
}
