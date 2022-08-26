import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';

class ShowcaseItemView extends StatelessWidget {
  ShowcaseItemView({
    Key? key,
  }) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: DelayedDisplay(
            delay: const Duration(milliseconds: 200),
            fadingDuration: const Duration(milliseconds: 300),
            slidingBeginOffset: Offset(0, -0.2),
            child: AnimatedShowcaseItemWidget(),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ValueListenableBuilder(
              valueListenable: uiMenuManager.menuIndex,
              builder: (context, value, child) {
                return AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: value != 1
                      ? SizedBox()
                      : DelayedDisplay(
                          delay: const Duration(milliseconds: 200),
                          fadingDuration: const Duration(milliseconds: 300),
                          child: CarouselController(),
                        ),
                );
              }),
        ),
      ],
    );
  }
}

class MobileShowcaseItemView extends StatelessWidget {
  MobileShowcaseItemView({
    Key? key,
  }) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        width: width,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            SizedBox(width: width, child: MobileAnimatedShowcaseItemWidget()),
            ValueListenableBuilder<bool>(
                valueListenable: uiShowcaseManager.showTutorialOverlay,
                builder: (context, value, child) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: !value
                        ? SizedBox()
                        : Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              color: GlobalColors.darkGrey.withOpacity(.7),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.arrow_left_right_circle,
                                  color: Colors.white,
                                  size: 42,
                                ),
                                Text(
                                  "Swipe left or right to change current item",
                                  textAlign: TextAlign.center,
                                  style: context.headline6?.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                TextButton(
                                  style: GlobalStyles.whiteTextButtonStyle(),
                                  onPressed: () {
                                    uiShowcaseManager
                                        .showTutorialOverlay.value = false;
                                  },
                                  child: Text(
                                    "Got it.",
                                    style: context.bodyText1?.copyWith(
                                      color: GlobalColors.primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
