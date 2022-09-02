import 'package:flutter/material.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/widgets/fade_in_slide.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuDesktop extends StatelessWidget {
  MenuDesktop({Key? key}) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FadingSlideWidget(
      noFade: true,
      offset: Offset(0, -2),
      child: Container(
        height: 60,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () async => await launchUrlString(Globals.githubUrl),
                child: Container(
                  width: 60,
                  height: 32,
                  child: Center(
                    child: Text(
                      "ED",
                      style: context.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 280,
                child: ValueListenableBuilder<int>(
                  valueListenable: uiMenuManager.menuIndex,
                  builder: (_, value, __) {
                    final _selectedIndex = value;
                    return ListView.separated(
                      itemCount: Globals.menu.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () async {
                            uiMenuManager.updateMenuCommand.execute(index);
                          },
                          child: Container(
                            color:
                                _selectedIndex == index ? Colors.white : null,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              Globals.menu[index],
                              style: context.bodyText1?.copyWith(
                                  color: _selectedIndex == index
                                      ? GlobalColors.primaryColor
                                      : Colors.white,
                                  fontWeight: _selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 24);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
