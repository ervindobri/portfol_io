import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class CarouselController extends StatefulWidget {
  const CarouselController({super.key});

  @override
  State<CarouselController> createState() => _CarouselControllerState();
}

class _CarouselControllerState extends State<CarouselController> {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    //TODO: left, right arrow actions -> prev/next item
    const padding = EdgeInsets.fromLTRB(12, 8, 12, 8);
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem?>>(
        valueListenable: uiShowcaseManager.currentItemCommand.results,
        builder: (context, value, __) {
          final currentIndex = uiShowcaseManager.currentPage;
          final totalItems = uiShowcaseManager.showcaseItems.length;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: GlobalStyles.whiteTextButtonStyle(),
                onPressed: () {
                  uiShowcaseManager.previousItemCommand.execute();
                },
                child: Container(
                  color: Colors.white,
                  padding: padding,
                  child: Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.chevronLeft,
                          size: 16, color: GlobalColors.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        "Previous",
                        style: context.bodyText1
                            ?.copyWith(color: GlobalColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "$currentIndex/$totalItems",
                style: context.bodyText1?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w100),
              ),
              const SizedBox(width: 16),
              TextButton(
                style: GlobalStyles.whiteTextButtonStyle(),
                onPressed: () => uiShowcaseManager.nextItemCommand.execute(),
                child: Container(
                  color: Colors.white,
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                        child: Text(
                          "Next",
                          style: context.bodyText1
                              ?.copyWith(color: GlobalColors.primaryColor),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const FaIcon(FontAwesomeIcons.chevronRight,
                          size: 16, color: GlobalColors.primaryColor),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
