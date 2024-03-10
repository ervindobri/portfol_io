import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/extensions/list.dart';

class BGShapes extends ConsumerWidget {
  const BGShapes({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeProvider);
    return Builder(builder: (context) {
      const shapeCount = 4;
      return Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            shapeCount,
            (index) => Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                24),
                        gradient: LinearGradient(
                          colors: [
                            theme.containerColor,
                            theme
                                .extBackgroundColor,
                          ],
                        ),
                      ),
                      width: width,
                    ),
                  ),
                ],
              ),
            ),
          )
              .expandWithSeparator<Widget>(
                  (element) => element,
                  const SizedBox(height: 48))
              ,
        ],
      );
    });
  }
}
