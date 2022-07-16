import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class AnimatedShowcaseItemWidget extends StatelessWidget {
  final UiShowcaseManager uiShowcaseManager = sl<UiShowcaseManager>();

  AnimatedShowcaseItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<CommandResult<int?, ShowcaseItem>>(
        valueListenable: uiShowcaseManager.currentItemCommand.results,
        builder: (context, value, __) {
          final item = value.data!;
          return TweenAnimationBuilder(
              key: Key(item.projectName),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              builder: (context, double value, _) {
                return TweenAnimationBuilder(
                    key: Key(item.projectName),
                    tween: Tween<double>(begin: 25.0, end: 0.0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, double value2, _) {
                      return Transform.translate(
                        offset: Offset(0, value2),
                        child: Opacity(
                          opacity: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //TODO: item images carousel here
                              Expanded(
                                child: Container(color: Colors.amberAccent),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.projectName,
                                      textAlign: TextAlign.right,
                                      style: context.headline4!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      item.duration,
                                      textAlign: TextAlign.right,
                                      style: context.headline6!.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 24),
                                    SizedBox(
                                      width: width / 3,
                                      child: Text(
                                        item.description,
                                        maxLines: 5,
                                        textAlign: TextAlign.right,
                                        style: context.bodyText1!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                    Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          //TODO: launch item.url
                                        },
                                        child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.fromLTRB(
                                                24, 12, 24, 12),
                                            child: Text(
                                              Globals.checkItOut,
                                              style: context.headline6!
                                                  .copyWith(
                                                      color: GlobalColors
                                                          .primaryColor),
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
