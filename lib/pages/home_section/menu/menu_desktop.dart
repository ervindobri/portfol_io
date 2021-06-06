import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class MenuDesktop extends StatelessWidget {
  const MenuDesktop({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              width: Get.width * .05,
              height: 100,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/logo1.png"))),
            ),
          ),
          Row(
            children: [
              Row(
                children: List.generate(
                    Globals.menu.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: InkWell(
                            onTap: () async {
                              // _itemScrollController.scrollTo(
                              //     index: index,
                              //     duration: Duration(milliseconds: 300),
                              //     curve: Curves.easeInOutCirc);
                              // setState(() {
                              //   animateCurrentPage(index);
                              // });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Globals.menu[index],
                                  style: TextStyle(
                                    color: ThemeUtils.primaryColor,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: _selectedIndex == index
                                          ? ThemeUtils.primaryColor
                                          : Colors.transparent,
                                      shape: BoxShape.circle),
                                )
                              ],
                            ),
                          ),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeUtils.primaryColor),
                      shadowColor:
                          MaterialStateProperty.all(ThemeUtils.primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {
                    print("button");
                  },
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
}
