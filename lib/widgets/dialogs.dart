import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/list.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

class Dialogs {
  static Future<void> showThemeDialog(
      BuildContext context, WidgetRef ref) async {
    await showGeneralDialog(
        context: context,
        barrierLabel: '',
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            )),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: true,
        pageBuilder: (_, __, ___) {
          final theme = ref.watch(themeProvider);
          final themeColor = ref.watch(themeColorProvider);
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 48,
            backgroundColor: theme.canvasColor,
            shadowColor: theme.extBackgroundColor,  
            child: Container(
              width: context.width * .7,
              decoration: BoxDecoration(
                color: theme.extBackgroundColor.withAlpha(153),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(24),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 24,
                children: [
                  ...List.generate(
                    GlobalColors.themeColors.length,
                    (index) {
                      final color = GlobalColors.themeColors[index];
                      final hoverColor = color.withAlpha(102);
                      final isSelected = themeColor == color;
                      return InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          ref
                              .read(themeProvider.notifier)
                              .changeThemeColor(color);
                          // Navigator.pop(context);
                        },
                        child: HoverWidget(builder: (context, hovering) {
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
                ],
              ),
            ),
          );
        });
  }
}
