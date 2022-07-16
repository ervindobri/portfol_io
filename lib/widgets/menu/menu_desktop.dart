import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/constants/theme_utils.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';

class MenuDesktop extends StatelessWidget {
  MenuDesktop({Key? key}) : super(key: key);

  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo1.png"),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: 280,
            child: ValueListenableBuilder<CommandResult<int?, int>>(
              valueListenable: uiMenuManager.updateMenuCommand.results,
              builder: (_, value, __) {
                final _selectedIndex = value.data ?? 0;
                return ListView.separated(
                  itemCount: Globals.menu.length,
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
                          style: context.bodyText1?.copyWith(
                              color: _selectedIndex == index
                                  ? GlobalColors.primaryColor
                                  : Colors.white,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.w900
                                  : FontWeight.w100),
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
    );
  }
}
