import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/build_context.dart';
import 'package:portfol_io/extensions/list.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/download_manager.dart';
import 'package:portfol_io/pages/contact/widgets/resume_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParallaxCard extends StatelessWidget {
  const ParallaxCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isBigScreen = context.width >= Globals.maxBoxWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SelectableText(
              Globals.myName,
              style: context.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.theme.inverseTextColor,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              Globals.myEmail,
              maxLines: 2,
              style: context.bodyText1,
            ),
          ],
        ),
        SizedBox(
          width: isBigScreen ? context.width * 3 / 12 : context.width * 4 / 12,
          child: Wrap(
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...Globals.mySkills
                  .map(
                    (e) => SelectableText(
                      e,
                      style: context.bodyText1
                          ?.copyWith(fontWeight: FontWeight.w200),
                    ),
                  )
                  .expandWithSeparator(
                    (e) => e,
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.inverseTextColor,
                      ),
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildInfoRow(
              context,
              Globals.myWorkplace,
              url: Globals.myWorkplaceUrl,
              icon: SvgPicture.asset(AppIcons.workplace),
            ),
            buildInfoRow(
              context,
              Globals.myLocation,
              icon: SvgPicture.asset(AppIcons.location),
            ),
            buildInfoRow(
              context,
              Globals.myUniversity,
              icon: SvgPicture.asset(AppIcons.book),
            ),
          ]
              .expandWithSeparator(
                (e) => e,
                const SizedBox(height: 12),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        const ResumeButton(),
      ],
    );
  }

  Widget buildInfoRow(BuildContext context, String label,
      {IconData? data, Widget? icon, String? url}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        data != null
            ? FaIcon(
                data,
                color: Colors.white,
                size: 16,
              )
            : icon!,
        const SizedBox(width: 12),
        InkWell(
          onTap: url != null
              ? () async {
                  await launchUrlString(url);
                }
              : null,
          child: Flexible(
            child: Text(
              label,
              maxLines: 2,
              style: context.bodyText1?.copyWith(
                decoration: url != null ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileParallaxCard extends StatelessWidget {
  MobileParallaxCard({super.key});

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
            offset: const Offset(0, 1),
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
                  Text(
                    "Flutter Developer / Aspiring UI/UX Designer",
                    maxLines: 2,
                    style: context.bodyText1?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const ResumeButton(),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          const ClipboardData(text: "ervindobri@gmail.com"));

                      toast('Copied to clipboard!');
                    },
                    child: const Text(
                      "ervindobri@gmail.com",
                    ),
                  ),
                  const Text(
                    "+40 754 365 846",
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(direction: Axis.vertical, spacing: 12, children: [
                buildInfoRow(
                  context,
                  Globals.myUniversity,
                  FontAwesomeIcons.buildingColumns,
                ),
                buildInfoRow(
                  context,
                  Globals.myLocation,
                  CupertinoIcons.location,
                ),
              ]),
            ],
          ),
          const Positioned(
            top: -128,
            child: SizedBox(
              width: 256,
              height: 256,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Positioned(
                  //   child: Image.memory(base64Decode(Globals.avatarImageBase64),
                  //       width: imageSize, height: imageSize),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(BuildContext context, String label, IconData data) {
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
