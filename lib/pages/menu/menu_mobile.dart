import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/constants/colors.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

class MenuMobile extends ConsumerStatefulWidget {
  MenuMobile({super.key});

  @override
  ConsumerState<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends ConsumerState<MenuMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  void initState() {
    uiMenuManager.scrollController.addListener(() {
      final index = uiMenuManager.getCurrentIndex();
      if (index == ref.read(menuIndexProvider)) return;
      if (kDebugMode) {
        print("update menu to $index");
      }
      ref.read(menuIndexProvider.notifier).update((state) => index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uiMenuManager = sl<UiMenuManager>();

    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final selectedIndex = ref.watch(menuIndexProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: Container(
        height: kToolbarHeight,
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.transparent,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: Globals.menu.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, index) {
                    final isSelected = selectedIndex == index;
                    return HoverWidget(builder: (context, isHovered) {
                      return InkWell(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        hoverColor: themeColor.withOpacity(.3),
                        splashColor: Colors.transparent,
                        onTap: () async {
                          uiMenuManager.updateMenuCommand.execute(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          decoration: isSelected
                              ? null
                              : BoxDecoration(
                                  borderRadius: GlobalStyles.borderRadius,
                                  color: isHovered
                                      ? themeColor.withOpacity(.1)
                                      : Colors.transparent,
                                ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                Globals.menu[index],
                                style: context.bodyText2?.copyWith(
                                  color: isSelected
                                      ? themeColor
                                      : isHovered
                                          ? themeColor.withOpacity(.7)
                                          : theme.inverseTextColor,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                ),
              ),
              // Row(
              //   children: [
              //     Container(
              //       color: themeColor,
              //       child: Material(
              //         type: MaterialType.transparency,
              //         child: InkWell(
              //           splashColor: Colors.transparent,
              //           onTap: () async => await showThemeDialog(context, ref),
              //           hoverColor: themeColor,
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 6, horizontal: 8),
              //             child: Text(
              //               Globals.themeLabel,
              //               style: theme.textTheme.labelSmall?.copyWith(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 12),
              //     _buildBrightnessButton(ref, theme),
              //     const SizedBox(width: 12),
              //     InkWell(
              //       onTap: () async => await launchUrlString(Globals.githubUrl),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: theme.inverseTextColor,
              //         ),
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 4, horizontal: 4),
              //         child: Image.asset(
              //           AppIcons.github,
              //           color: theme.textColor,
              //           width: 24,
              //           height: 24,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
