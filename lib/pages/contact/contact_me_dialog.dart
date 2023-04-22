import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailto/mailto.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum PlatformType { desktop, tablet, mobile }

class ContactMeDialog extends StatefulWidget {
  const ContactMeDialog._({Key? key, required this.platformType})
      : super(key: key);

  factory ContactMeDialog.mobile({platformType = PlatformType.mobile}) =>
      ContactMeDialog._(platformType: platformType);

  factory ContactMeDialog.desktop({platformType = PlatformType.desktop}) =>
      ContactMeDialog._(platformType: platformType);

  final PlatformType platformType;
  @override
  State<ContactMeDialog> createState() => _ContactMeDialogState();
}

class _ContactMeDialogState extends State<ContactMeDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final FocusNode emailFocusNode;
  @override
  void initState() {
    emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDesktop = widget.platformType == PlatformType.desktop;
    final dialogWidth = isDesktop ? width * .5 : width;
    final dialogHeight = isDesktop ? height * .75 : height;
    final double padding = isDesktop ? 48 : 16;
    WidgetsBinding.instance.addPostFrameCallback((ads) {
      emailFocusNode.requestFocus();
    });
    return Container(
      width: dialogWidth,
      height: dialogHeight,
      color: GlobalColors.primaryColor,
      padding: EdgeInsets.all(padding),
      child: DefaultTextStyle(
        style: context.bodyText1 ?? const TextStyle(),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 48,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    height: 64,
                    width: 64,
                    color: GlobalColors.primaryColor,
                    child: const Center(
                      child: Icon(CupertinoIcons.xmark,
                          size: 24, color: Colors.white),
                    ),
                  ),
                ),
                //email
                _buildFormRow(
                  "Email",
                  field: FormBuilderTextField(
                    name: 'email',
                    autofocus: true,
                    focusNode: emailFocusNode,
                    style: context.bodyText1?.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: GlobalStyles.inputDecoration(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                //title
                _buildFormRow(
                  "Subject",
                  field: FormBuilderTextField(
                    name: 'subject',
                    autofocus: true,
                    style: context.bodyText1?.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: GlobalStyles.inputDecoration(),
                  ),
                ),
                //message
                _buildFormRow(
                  "Message",
                  field: FormBuilderTextField(
                    name: 'body',
                    autofocus: true,
                    style: context.bodyText1?.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (val) {
                      sendEmail(context);
                      Navigator.pop(context);
                    },
                    decoration: GlobalStyles.inputDecoration(),
                    keyboardType: TextInputType.multiline,
                    maxLines:
                        widget.platformType == PlatformType.mobile ? 3 : 10,
                  ),
                ),
                const SizedBox(),
                //button
                TextButton(
                  onPressed: () {
                    sendEmail(context);
                    Navigator.pop(context);
                  },
                  style: GlobalStyles.whiteTextButtonStyle(),
                  child: Container(
                    color: GlobalColors.white,
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                    child: Text("Send",
                        style: context.bodyText1?.copyWith(
                          color: GlobalColors.primaryColor,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormRow(String label, {required Widget field}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        field,
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> sendEmail(BuildContext context) async {
    if (_formKey.currentState?.saveAndValidate() == true) {
      final data = _formKey.currentState!.value;
      final mailtoLink = Mailto(
        to: [Globals.myEmail],
        subject: data['subject'] ?? '',
        body: data['body'] ?? '',
      );
      // Convert the Mailto instance into a string.
      // Use either Dart's string interpolation
      // or the toString() method.
      await launchUrlString('$mailtoLink');
    }
  }
}
