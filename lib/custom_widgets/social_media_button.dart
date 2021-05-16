import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfol_io/constants/theme_utils.dart';

class SocialMediaBubble extends StatefulWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String href;

  const SocialMediaBubble({Key? key, required this.icon, required this.href, this.bgColor = CupertinoColors.white, this.iconColor = ThemeUtils.primaryColor}) : super(key: key);
  @override
  _SocialMediaBubbleState createState() => _SocialMediaBubbleState();
}

class _SocialMediaBubbleState extends State<SocialMediaBubble> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("launch url");
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: widget.bgColor,
          shape: BoxShape.circle
        ),
        child: Center(
          child: FaIcon(
            widget.icon,
            color: widget.iconColor,
          ),
        ),
      ),
    );
  }
}
