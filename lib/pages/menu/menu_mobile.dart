import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/menu/widgets/brightness_button.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/dialogs.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class MenuMobile extends ConsumerStatefulWidget {
  const MenuMobile({super.key});

  @override
  ConsumerState<MenuMobile> createState() => _MenuMobileState();
}

class _MenuMobileState extends ConsumerState<MenuMobile> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  void initState() {
    // uiMenuManager.scrollController.addListener(() {
    //   final index = uiMenuManager.getCurrentIndex();
    //   if (index == ref.read(menuIndexProvider)) return;
    //   if (kDebugMode) {
    //     print("update menu to $index");
    //   }
    //   ref.read(menuIndexProvider.notifier).update((state) => index);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uiMenuManager = sl<UiMenuManager>();
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    return ValueListenableBuilder(
      valueListenable: uiMenuManager.menuIndex,
      builder: (context, selectedIndex, child) {
        return ClipRRect(
          child: ProAnimatedBlur(
            blur: 32,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: Container(
              width: context.width,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withAlpha(240),
              ),
              padding: EdgeInsets.only(top: context.topPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: Globals.menu.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      separatorBuilder: (_, __) => const SizedBox(width: 4),
                      itemBuilder: (_, index) {
                        final isSelected = selectedIndex == index;
                        return InkWell(
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          hoverColor: themeColor.withAlpha(77),
                          splashColor: Colors.transparent,
                          onTap: () => uiMenuManager.setPage(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            decoration: isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: GlobalStyles.borderRadius,
                                    color: Colors.transparent,
                                  ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  Globals.menu[index],
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: isSelected
                                        ? themeColor
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
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        color: themeColor,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () async =>
                                await Dialogs.showThemeDialog(context, ref),
                            hoverColor: themeColor,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: FaIcon(
                                FontAwesomeIcons.brush,
                                color: context.theme.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const BrightnessButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
