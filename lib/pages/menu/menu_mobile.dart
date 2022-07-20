import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';

class MenuMobile extends StatelessWidget {
  MenuMobile({Key? key}) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 42,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: uiMenuManager.menuIndex,
              builder: (_, value, __) {
                final _selectedIndex = value;
                return ListView.separated(
                  itemCount: Globals.menu.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () async {
                        uiMenuManager.updateMenuCommand.execute(index);
                      },
                      child: Container(
                        color: _selectedIndex == index ? Colors.white : null,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          Globals.menu[index],
                          style: _selectedIndex == index
                              ? context.bodyText1?.copyWith(
                                  fontSize: 16,
                                  color: GlobalColors.primaryColor,
                                  fontWeight: FontWeight.w700)
                              : context.bodyText2?.copyWith(
                                  fontSize: 16,
                                  color: GlobalColors.white,
                                  fontWeight: FontWeight.w300),
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
          ],
        ),
      ),
    );
  }
}
