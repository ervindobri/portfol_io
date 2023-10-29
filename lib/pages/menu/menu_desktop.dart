import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/extensions/list.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

// TODO: menuIndex listener to update the provider
class MenuDesktop extends ConsumerStatefulWidget {
  const MenuDesktop({Key? key}) : super(key: key);

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
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);
    final selectedIndex = ref.watch(menuIndexProvider);
    return ClipRRect(
      child: Container(
        height: kToolbarHeight,
        width: width,
        padding:
            GlobalStyles.horizontalScreenPadding.copyWith(top: 12, bottom: 12),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: Globals.menu.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final isSelected = selectedIndex == index;
                  return InkWell(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    splashColor: Colors.transparent,
                    onTap: () async {
                      uiMenuManager.updateMenuCommand.execute(index);
                    },
                    child: Row(
                      children: [
                        AnimatedOpacity(
                            opacity: isSelected ? 1 : 0,
                            duration: kThemeAnimationDuration,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: GlobalStyles.borderRadius,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            )),
                        Text(
                          Globals.menu[index],
                          style: context.bodyText1?.copyWith(
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 48);
                },
              ),
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () async => await showThemeDialog(context, ref),
                  child: Container(
                    color: themeColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Center(
                      child: Text(
                        Globals.themeLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
          child: isDarkMode
              ? Image.asset(
                  AppIcons.bulbLight,
                  color: theme.textColor,
                  width: 24,
                  height: 24,
                )
              : Image.asset(
                  AppIcons.bulbDark,
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

    await showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.slideFromTop,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 300),
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (_) {
          final theme = ref.watch(themeProvider);
          final themeColor = ref.watch(themeColorProvider);
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 48,
            backgroundColor: theme.extBackgroundColor.withOpacity(.6),
            shadowColor: theme.extBackgroundColor,
            child: Container(
              width: 676,
              height: 220,
              decoration: BoxDecoration(
                color: theme.extBackgroundColor.withOpacity(.6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 24),
                  ...List.generate(
                    GlobalColors.themeColors.length,
                    (index) {
                      final color = GlobalColors.themeColors[index];
                      final hoverColor = color.withOpacity(.4);
                      final isSelected = themeColor == color;
                      return InkWell(
                        onTap: () {
                          ref
                              .read(themeProvider.notifier)
                              .changeThemeColor(color);
                          // Navigator.pop(context);
                        },
                        child: HoverWidget(builder: (hovering) {
                          return AnimatedContainer(
                            duration: kThemeAnimationDuration,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: hovering ? hoverColor : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? color : Colors.white,
                                width: isSelected ? 4 : 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: color,
                                ),
                                if (isSelected)
                                  const FaIcon(
                                    FontAwesomeIcons.check,
                                    color: Colors.white,
                                  )
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  ).expandWithSeparator(
                    (element) => element,
                    const SizedBox(width: 24),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
          );
        });
  }
}
