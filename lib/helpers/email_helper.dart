import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EmailHelper {
  static Future<void> contactMe() async {
    const mailUrl =
        'mailto:${Globals.myEmail}?subject=${Globals.emailSubject}&body=${Globals.emailBody}';
    try {
      await launchUrlString(mailUrl);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      await Clipboard.setData(
        const ClipboardData(text: Globals.myEmail),
      );
    }
  }
}
