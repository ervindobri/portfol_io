import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mouse_parallax/mouse_parallax.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/download_manager.dart';

class ParallaxCard extends StatelessWidget {
  ParallaxCard({Key? key}) : super(key: key);

  final downloadManager = sl<DownloadManager>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = 256.0;
    final containerHeight = height * .6;
    return Container(
      height: containerHeight,
      width: width / 4 + 96,
      child: ParallaxStack(
        layers: [
          ParallaxLayer(
            yRotation: .15,
            xRotation: .15,
            // zRotation: .05,
            child: Container(
              height: containerHeight,
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
                              "Junior Software Developer / Aspiring UI/UX Designer",
                              maxLines: 2,
                            ),
                            SizedBox(height: 24),
                            Text(
                              Globals.inspiration,
                              style: context.bodyText1
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 24),
                            TextButton.icon(
                              onPressed: () async {
                                downloadManager.downloadFile
                                    .execute("assets/files/CV.pdf");
                              },
                              style: GlobalStyles.whiteTextButtonStyle(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              ),
                              icon: Icon(
                                CupertinoIcons.cloud_download,
                                color: GlobalColors.primaryColor,
                              ),
                              label: Text('Download Resume',
                                  style: context.bodyText1?.copyWith(
                                    color: GlobalColors.primaryColor,
                                  )),
                            ),
                            SelectableText(
                              "ervindobri@gmail.com",
                            ),
                            SelectableText(
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
                            Globals.myLocation,
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
                              child: Image.memory(
                                base64Decode(Globals.avatarImageBase64),
                              ),
                              width: imageSize,
                              height: imageSize),
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
        SelectableText(
          label,
          style: context.bodyText1?.copyWith(),
        ),
      ],
    );
  }
}

class MobileParallaxCard extends StatelessWidget {
  MobileParallaxCard({Key? key}) : super(key: key);

  final downloadManager = sl<DownloadManager>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSize = width / 3;
    final containerHeight = height * .55;
    return Container(
      height: containerHeight,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(height: imageSize / 2),
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    "Ervin Dobri (23)",
                    style: context.bodyText1
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text("Junior Software Developer / Aspiring UI/UX Designer",
                      maxLines: 2,
                      style: context.bodyText1?.copyWith(
                        fontSize: 12,
                      )),
                  SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () async {
                      downloadManager.downloadFile
                          .execute("assets/files/CV.pdf");
                    },
                    style: GlobalStyles.whiteTextButtonStyle(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    ),
                    icon: Icon(
                      CupertinoIcons.cloud_download,
                      color: GlobalColors.primaryColor,
                    ),
                    label: Text('Download Resume',
                        style: context.bodyText1?.copyWith(
                          color: GlobalColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: "ervindobri@gmail.com"));

                      toast('Copied to clipboard!');
                    },
                    child: Text(
                      "ervindobri@gmail.com",
                    ),
                  ),
                  Text(
                    "+40 754 365 846",
                  ),
                ],
              ),
              SizedBox(height: 24),
              Wrap(direction: Axis.vertical, spacing: 12, children: [
                buildInfoRow(
                  context,
                  Globals.myUniversity,
                  FontAwesomeIcons.university,
                ),
                buildInfoRow(
                  context,
                  Globals.myLocation,
                  CupertinoIcons.location,
                ),
              ]),
            ],
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
                    child: Image.memory(base64Decode(Globals.avatarImageBase64),
                        width: imageSize, height: imageSize),
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
        FaIcon(data, color: Colors.white, size: 16),
        Text(
          label,
          style: context.bodyText1?.copyWith(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
