import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion/motion.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/constants/images.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/providers/providers.dart';
import 'package:portfol_io/widgets/animated_highlight_widget.dart';
import 'package:portfol_io/widgets/hover_button.dart';
import 'package:portfol_io/extensions/list.dart';

class HomeDesktop extends ConsumerStatefulWidget {
  HomeDesktop({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends ConsumerState<HomeDesktop> {
  final uiMenuManager = sl<UiMenuManager>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeProvider);
    final previousColor = ref.watch(previousThemeColorProvider);
    final nextColor = ref.watch(themeColorProvider);
    return TweenAnimationBuilder<Color?>(
        // <-- Color might be null
        tween: ColorTween(begin: previousColor, end: nextColor),
        duration: Duration(milliseconds: 500),
        builder: (_, Color? themeColor, __) {
          // <-- Colo
          return ClipRRect(
            child: Container(
              height: height,
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //Content
                  Container(
                    height: height - kToolbarHeight * 3,
                    child: Row(
                      children: [
                        //left
                        Expanded(
                          child: DelayedDisplay(
                            slidingBeginOffset: Offset(-1, 0),
                            delay: const Duration(seconds: 1),
                            child: Motion(
                              glare: GlareConfiguration(
                                maxOpacity: 0,
                                minOpacity: 0,
                                color: Colors.transparent,
                              ),
                              shadow: ShadowConfiguration(
                                opacity: 0,
                                color: Colors.transparent,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.containerColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(128),
                                    bottomLeft: Radius.circular(128),
                                    topRight: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(48),
                                margin:
                                    const EdgeInsets.only(top: kToolbarHeight),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 48),
                                        Text(
                                          "my name is",
                                          style: theme.nameStyleSmall?.copyWith(
                                            fontSize: 24,
                                          ),
                                        ),
                                        Text(
                                          "Ervin Dobri",
                                          style: theme.nameStyleLarge,
                                        ),
                                        DefaultTextStyle(
                                          style: theme.nameStyleLarge ??
                                              TextStyle(),
                                          child: Row(
                                            children: [
                                              Text("I"),
                                              SizedBox(width: 24),
                                              SizedBox(
                                                width: "create".length * 60,
                                                child: DefaultTextStyle(
                                                  style: theme.nameStyleLarge!
                                                      .copyWith(
                                                    color: themeColor,
                                                  ),
                                                  child: AnimatedTextKit(
                                                    repeatForever: true,
                                                    pause: Duration(seconds: 2),
                                                    animatedTexts: [
                                                      ...[
                                                        "design",
                                                        "create",
                                                        "code"
                                                      ].map(
                                                        (e) =>
                                                            TyperAnimatedText(
                                                          e,
                                                          speed: Duration(
                                                            milliseconds: 200,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    onTap: () {
                                                      print("Tap Event");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 24),
                                              Text("value"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(48),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStatePropertyAll(
                                                    themeColor),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              return theme.inverseTextColor;
                                            }),
                                          ),
                                          onPressed: () {
                                            //hire me
                                            uiMenuManager.updateMenuCommand
                                                .execute(2);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 24, horizontal: 24),
                                            child: Row(
                                              children: [
                                                Text(
                                                  Globals.hireMe,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                          color:
                                                              theme.textColor),
                                                ),
                                                SizedBox(width: 24),
                                                SvgPicture.asset(
                                                  AppIcons.coffee,
                                                  height: 32,
                                                  width: 32,
                                                  colorFilter: ColorFilter.mode(
                                                    theme.textColor,
                                                    BlendMode.srcIn,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        DelayedDisplay(
                                          delay: const Duration(
                                              milliseconds: 1000),
                                          slidingBeginOffset: Offset(0, 2),
                                          slidingCurve: Curves.easeInOut,
                                          fadingDuration:
                                              Duration(milliseconds: 300),
                                          child: MouseRegion(
                                            child: HoverWidget(
                                              builder: (hovering) => InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                onTap: () => uiMenuManager
                                                    .updateMenuCommand
                                                    .execute(1),
                                                child: AnimatedContainer(
                                                  decoration: BoxDecoration(
                                                      color: themeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              hovering
                                                                  ? 12
                                                                  : 8),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: themeColor!
                                                              .withOpacity(
                                                            hovering
                                                                ? .24
                                                                : .12,
                                                          ),
                                                          offset: Offset(0, 24),
                                                          blurRadius: 24,
                                                          spreadRadius: -2,
                                                        ),
                                                      ]),
                                                  padding: const EdgeInsets.all(
                                                      24.0),
                                                  duration:
                                                      kThemeAnimationDuration,
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .chevronDown,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 48),
                        Expanded(
                          child: DelayedDisplay(
                            slidingBeginOffset: Offset(1, 0),
                            delay: const Duration(seconds: 2),
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: kToolbarHeight),
                              child: Stack(
                                children: [
                                  Builder(builder: (context) {
                                    final shapeCount = 4;
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
                                                SizedBox(height: 48))
                                            .toList(),
                                      ],
                                    );
                                  }),
                                  Container(
                                    margin: EdgeInsets.only(left: 48),
                                    decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(666),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(128),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(48),
                                    alignment: Alignment.centerRight,
                                    child: DelayedDisplay(
                                      delay: Duration(seconds: 2),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ...List.generate(
                                            Globals.highlightList.length,
                                            (index) {
                                              return AnimatedHighlightWidget(
                                                  index: index);
                                            },
                                          ).expandWithSeparator(
                                            (element) => element,
                                            SizedBox(
                                              height: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -24,
                                    bottom: 0,
                                    child: DelayedDisplay(
                                      slidingBeginOffset: Offset(0, 2),
                                      delay: const Duration(seconds: 2),
                                      child: HoverWidget(
                                        builder: (hovering) {
                                          return AnimatedScale(
                                            duration: kThemeAnimationDuration,
                                            scale: hovering ? 1.025 : 1,
                                            child: Image.asset(
                                              AppImages.me,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
