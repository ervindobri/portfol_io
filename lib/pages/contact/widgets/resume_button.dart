import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/icons.dart';
import 'package:portfol_io/extensions/theme_ext.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/download_manager.dart';

class ResumeButton extends StatelessWidget {
  const ResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadManager = sl<DownloadManager>();

    return TextButton(
      onPressed: downloadManager.downloadResume,
      style: context.textButtonStyle,
      child: Padding(
        padding: GlobalStyles.textButtonPadding(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Globals.downloadResume, style: context.bodyText1),
            const SizedBox(width: 12),
            SvgPicture.asset(
              AppIcons.downloadCloud,
              colorFilter: ColorFilter.mode(
                  context.theme.inverseTextColor, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
