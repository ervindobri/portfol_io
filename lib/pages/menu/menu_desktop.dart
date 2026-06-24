import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/pages/menu/widgets/brightness_button.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/dialogs.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuDesktop extends HookConsumerWidget {
  const MenuDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiMenuManager = sl<UiMenuManager>();
    final theme = ref.watch(themeProvider);
    final themeColor = ref.watch(themeColorProvider);

    final showMenu = useState(false);

    useEffect(() {
      const duration = Duration.zero;
      uiMenuManager.animateToPage(2, duration: duration).then((_) {
        uiMenuManager.animateToPage(1, duration: duration).then((_) {
          uiMenuManager.animateToPage(0, duration: duration).then((_) {
            showMenu.value = false;
          });
        });
      });
      return null;
    }, []);
    return ValueListenableBuilder(
      valueListenable: uiMenuManager.menuIndex,
      builder: (context, selectedIndex, child) => ClipRRect(
        child: ProAnimatedBlur(
          blur: 24,
          duration: kThemeAnimationDuration,
          child: Container(
            height: kToolbarHeight,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: context.theme.scaffoldBackgroundColor.withAlpha(220),
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Globals.maxBoxWidth,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 24,
                children: [
                  IconButton(
                    onPressed: () {
                      showMenu.value = !showMenu.value;
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.barsStaggered,
                      color: context.theme.primaryColor,
                      size: 24,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: !showMenu.value,
                    child: ListView.separated(
                      itemCount: Globals.menu.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (_, index) {
                        final isSelected = selectedIndex == index;
                        return FadeInLeft(
                          animate: showMenu.value,
                          duration: const Duration(milliseconds: 150),
                          delay: Duration(milliseconds: 50 * index),
                          child: HoverWidget(
                            builder: (_, isHovered) {
                              return InkWell(
                                hoverColor: themeColor.withAlpha(77),
                                onTap: () async {
                                  uiMenuManager.setPage(index);
                                },
                                child: Container(
                                  decoration: isSelected
                                      ? null
                                      : BoxDecoration(
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
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(width: 24),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      spacing: 12,
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
                        const BrightnessButton(),
                        InkWell(
                          onTap: () async =>
                              await launchUrlString(Globals.githubUrl),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
