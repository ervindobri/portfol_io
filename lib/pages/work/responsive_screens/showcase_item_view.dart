import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:portfol_io/providers/providers.dart';

extension<E> on Iterable<E> {
  Iterable<T> expandWithSeparator<T>(
    T Function(E element) toElement,
    T separator,
  ) sync* {
    bool first = true;

    for (final element in this) {
      if (first) {
        first = false;
      } else {
        yield separator;
      }
      yield toElement(element);
    }
  }
}

class ShowcaseItemView extends ConsumerWidget {
  const ShowcaseItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final themeColor = ref.watch(themeColorProvider);
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem?>>(
        valueListenable: uiShowcaseManager.currentItemCommand.results,
        builder: (context, value, __) {
          if (value.data == null) {
            return const SizedBox();
          }
          final item = value.data!;

          return Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: Row(
              // alignment: Alignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: AnimatedShowcaseItemWidget(item: item),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // TODO: replace with 3 other top items
                      ...List.generate(
                        3,
                        (index) => Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: themeColor,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(48),
                                )),
                          ),
                        ),
                      ).expandWithSeparator(
                        (e) => e,
                        const SizedBox(
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MobileShowcaseItemView extends StatelessWidget {
  MobileShowcaseItemView({
    Key? key,
  }) : super(key: key);

  final uiShowcaseManager = sl<UiShowcaseManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        width: width,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            SizedBox(width: width, child: MobileAnimatedShowcaseItemWidget()),
            ValueListenableBuilder<bool>(
                valueListenable: uiShowcaseManager.showTutorialOverlay,
                builder: (context, value, child) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: !value
                        ? const SizedBox()
                        : Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              color: GlobalColors.darkGrey.withOpacity(.7),
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
                                Text(
                                  "Swipe left or right to change current item",
                                  textAlign: TextAlign.center,
                                  style: context.headline6?.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                TextButton(
                                  style: GlobalStyles.whiteTextButtonStyle(),
                                  onPressed: () {
                                    uiShowcaseManager
                                        .showTutorialOverlay.value = false;
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
                          ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
