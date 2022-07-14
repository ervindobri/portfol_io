import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(height: height, width: width, child: Text("WORK"));
  }
}
