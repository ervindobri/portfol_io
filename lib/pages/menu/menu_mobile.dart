import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/providers/providers.dart';

class MenuMobile extends ConsumerStatefulWidget {
  const MenuMobile({super.key});

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.containerColor.withAlpha(26),
              theme.containerColor.withAlpha(0)
            ],
          ),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: Globals.menu.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      Globals.menu[index],
                      style: context.bodyText2?.copyWith(
                        color: isSelected ? themeColor : theme.inverseTextColor,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
        ),
      ),
    );
  }
}
