import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MenuMobile extends ConsumerWidget {
  const MenuMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withAlpha(240),
              ),
              padding: EdgeInsets.only(top: context.topPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: kToolbarHeight,
                      child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: Globals.menu.length,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
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
                          onTap: () {
                            uiMenuManager.setPage(index);
                            HapticFeedback.lightImpact();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: GlobalStyles.borderRadius,
                                    color: Colors.transparent,
                                  ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  Globals.menu[index],
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: Color.lerp(
                                      theme.inverseTextColor,
                                      themeColor,
                                      isSelected ? 1 : 0,
                                    ),
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
