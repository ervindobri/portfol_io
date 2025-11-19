import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';

class ShowcaseItemView extends ConsumerWidget {
  const ShowcaseItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem?>>(
      valueListenable: uiShowcaseManager.currentItemCommand.results,
      builder: (context, value, __) {
        if (value.data == null) {
          return const SizedBox();
        }
        final item = value.data!;
        return AnimatedSwitcher(
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          key: ValueKey(item.hashCode),
          duration: kThemeAnimationDuration,
          child: AnimatedShowcaseItemWidget(item: item),
        );
      },
    );
  }
}

class MobileShowcaseItemView extends StatelessWidget {
  const MobileShowcaseItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: context.theme.containerColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: MobileAnimatedShowcaseItemWidget(),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: uiShowcaseManager.showTutorialOverlay,
            builder: (context, value, child) {
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: !value ? const SizedBox() : const TutorialOverlay(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TutorialOverlay extends StatelessWidget {
  const TutorialOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final uiShowcaseManager = sl<UiShowcaseManager>();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: GlobalColors.darkGrey.withAlpha(179),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.arrow_left_right_circle,
            color: Colors.white,
            size: 42,
          ),
          SelectableText(
            "Swipe left or right to change current item",
            textAlign: TextAlign.center,
            style: context.headline6?.copyWith(
              fontWeight: FontWeight.w100,
            ),
          ),
          TextButton(
            style: GlobalStyles.whiteTextButtonStyle(),
            onPressed: () {
              uiShowcaseManager.showTutorialOverlay.value = false;
            },
            child: Text(
              "Got it.",
              style: context.bodyText1?.copyWith(
                color: GlobalColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
