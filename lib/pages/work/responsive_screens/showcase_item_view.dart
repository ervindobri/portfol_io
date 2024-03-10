import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/hover_button.dart';

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
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiShowcaseManager = sl<UiShowcaseManager>();
    final themeColor = ref.watch(themeColorProvider);
    final width = MediaQuery.of(context).size.width;
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
                  child: AnimatedSwitcher(
                    key: ValueKey(item.hashCode),
                    duration: kThemeAnimationDuration,
                    child: AnimatedShowcaseItemWidget(item: item),
                  ),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 1,
                  child: Builder(builder: (_) {
                    final items = uiShowcaseManager.otherItems.take(3).toList();
                    return Column(
                      children: [
                        ...List.generate(
                          items.length,
                          (index) => Expanded(
                            child: AnimatedSwitcher(
                              key: ValueKey(items[index].hashCode),
                              duration: kThemeAnimationDuration,
                              child: HoverWidget(
                                builder: (hovering) {
                                  return InkWell(
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(48),
                                    ),
                                    onTap: () {
                                      uiShowcaseManager.select(items[index]);
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: themeColor,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(48),
                                        ),
                                      ),
                                      child: AnimatedScale(
                                        scale: hovering ? 1.1 : 1.0,
                                        duration: kThemeAnimationDuration,
                                        child: Image.asset(
                                          items[index].images.first,
                                          fit: BoxFit.fitWidth,
                                          width: width,
                                          // cacheWidth: width ~/ 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ).expandWithSeparator(
                          (e) => e,
                          const SizedBox(height: 24),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        });
  }
}

class MobileShowcaseItemView extends StatelessWidget {
  MobileShowcaseItemView({
    super.key,
  });

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
