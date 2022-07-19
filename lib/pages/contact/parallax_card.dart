import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';

class ParallaxCard extends StatelessWidget {
  const ParallaxCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 348.0;
    final containerHeight = height * .6;
    return Container(
      height: containerHeight,
      width: width / 4,
      child: ParallaxStack(
        layers: [
          ParallaxLayer(
            child: Container(
              height: containerHeight,
              width: width / 4,
              padding: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                color: GlobalColors.primaryColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 24,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(.2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 64 + 24,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              "Ervin Dobri (23)",
                              style: context.bodyText1
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Junior Flutter Developer / Aspiring UI/UX Designer",
                            ),
                            SizedBox(height: 24),
                            Text(
                              "ervindobri@gmail.com",
                            ),
                            Text(
                              "+40 754 365 846",
                            ),
                          ],
                        ),
                        Spacer(),
                        Wrap(direction: Axis.vertical, spacing: 12, children: [
                          buildInfoRow(
                            context,
                            "Sapientia EMTE, Targu Mures",
                            FontAwesomeIcons.university,
                          ),
                          buildInfoRow(
                            context,
                            "Targu Mures, Romania",
                            CupertinoIcons.location,
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -128,
                    child: Container(
                      width: 256,
                      height: 256,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              child: Image.asset("assets/avatar.png",
                                  width: imageSize, height: imageSize)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildInfoRow(BuildContext context, String label, IconData data) {
    return Wrap(
      spacing: 16,
      children: [
        FaIcon(
          data,
          color: Colors.white,
          size: 16,
        ),
        Text(
          label,
          style: context.bodyText1?.copyWith(),
        ),
      ],
    );
  }
}
