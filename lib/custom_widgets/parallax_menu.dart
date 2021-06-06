import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/controller/home_controller.dart';
import 'package:portfol_io/custom_widgets/fade_in_slide.dart';

class ParallaxMenu extends StatefulWidget {
  // const ParallaxMenu({Key? key}) : super(key: key);

  @override
  _ParallaxMenuState createState() => _ParallaxMenuState();
}

class _ParallaxMenuState extends State<ParallaxMenu> {
  HomeController homeController = Get.put(HomeController())!;

  var random = new Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2.2,
      width: Get.width > 1000 ? Get.width * .5 : Get.width * .65,
      // color: Colors.black,
      child: ParallaxStack(
        layers: [
          ParallaxLayer(
            yRotation: 0.35,
            xOffset: 10,
            xRotation: .3,
            child: Container(
              // color: Colors.black45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  greyButton(1, "Logo design", () {
                    print("hi");
                  }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      greyButton(0, "UX/UI design", () {}),
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: ThemeUtils.primaryColor,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/pic.jpeg"),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle)),
                        ),
                      ),
                      greyButton(3, "Desktop s", () {}),
                    ],
                  ),
                  greyButton(2, "Mobile Apps", () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  greyButton(int index, String title, VoidCallback onTap) => FadingSlideWidget(
        animation: homeController.buttonAnimations[index],
        offset: Offset(
            index % 2 == 0
                ? -(random.nextInt(10) + 1) / 10
                : (random.nextInt(10) + 1) / 10,
            0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ThemeUtils.lightGrey),
                shadowColor: MaterialStateProperty.all(ThemeUtils.lightGrey),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)))),
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: GoogleFonts.oswald(
                    color: ThemeUtils.white,
                    fontWeight: FontWeight.w100,
                    fontSize: min(Get.width / 40, 30)),
              ),
            ),
          ),
        ),
      );
}
