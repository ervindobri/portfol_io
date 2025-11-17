import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/dialogs.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuDesktop extends ConsumerStatefulWidget {
  const MenuDesktop({super.key});

  @override
  ConsumerState<MenuDesktop> createState() => _MenuDesktopState();
}

class _MenuDesktopState extends ConsumerState<MenuDesktop> {
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
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final selectedIndex = ref.watch(menuIndexProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: Container(
        height: kToolbarHeight,
        width: min(context.width, Globals.maxBoxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    return HoverWidget(builder: (_, isHovered) {
                      return InkWell(
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        hoverColor: themeColor.withAlpha(77),
                        splashColor: Colors.transparent,
                        onTap: () async {
                          uiMenuManager.setPage(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          decoration: isSelected
                              ? null
                              : BoxDecoration(
                                  borderRadius: GlobalStyles.borderRadius,
                                  color: isHovered
                                      ? themeColor.withAlpha(26)
                                      : Colors.transparent,
                                ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                Globals.menu[index],
                                style: context.bodyText1?.copyWith(
                                  color: isSelected
                                      ? themeColor
                                      : isHovered
                                          ? themeColor.withAlpha(178)
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
                  separatorBuilder: (_, __) => const SizedBox(width: 24),
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
                        onTap: () async => await showThemeDialog(context, ref),
                        hoverColor: themeColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: Text(
                            Globals.themeLabel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildBrightnessButton(ref, theme),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async => await launchUrlString(Globals.githubUrl),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.inverseTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Image.asset(
                        AppIcons.github,
                        color: theme.textColor,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildBrightnessButton(WidgetRef ref, ThemeData theme) {
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;
    return InkWell(
      onTap: () => ref.read(themeProvider.notifier).switchBrightness(),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: theme.inverseTextColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: Image.asset(
            isDarkMode ? AppIcons.bulbLight : AppIcons.bulbDark,
            color: theme.textColor,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }

  Future<void> showThemeDialog(context, WidgetRef ref) async {
    //themeManager.changeThemeColor(value)
    await Dialogs.showThemeDialog(context, ref);
  }
}
