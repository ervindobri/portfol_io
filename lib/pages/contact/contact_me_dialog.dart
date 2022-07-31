import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mailto/mailto.dart';
import 'package:portfol_io/constants/constants.dart';
import 'package:portfol_io/constants/theme_ext.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactMeDialog extends StatefulWidget {
  const ContactMeDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactMeDialog> createState() => _ContactMeDialogState();
}

class _ContactMeDialogState extends State<ContactMeDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDesktop = width > 1000;
    final dialogWidth = width > 1000 ? width * .5 : width * .9;
    final dialogHeight = height > 1000 ? height * .65 : height * .8;
    final double padding = isDesktop ? 48 : 24;
    return Container(
      width: dialogWidth,
      height: dialogHeight,
      color: GlobalColors.primaryColor,
      padding: EdgeInsets.all(padding),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //email
            _buildFormRow(
              "Email",
              field: FormBuilderTextField(
                name: 'email',
                autofocus: true,
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
                decoration: GlobalStyles.inputDecoration(),
              ),
            ),
            //message
            _buildFormRow(
              "Message",
              field: FormBuilderTextField(
                name: 'body',
                autofocus: true,
                decoration: GlobalStyles.inputDecoration(),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
              ),
            ),
            Spacer(),
            //button
            TextButton(
              onPressed: () {
                sendEmail(context);
                Navigator.pop(context);
              },
              style: GlobalStyles.whiteTextButtonStyle(),
              child: Container(
                color: GlobalColors.green,
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: Text("Send",
                    style: context.bodyText1?.copyWith(
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFormRow(String s, {required Widget field}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Text(
          s,
          style: TextStyle(color: Colors.white),
        ),
        field,
        SizedBox(height: 16),
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
