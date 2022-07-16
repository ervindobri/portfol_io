import 'package:flutter/material.dart';

class WorkMobile extends StatefulWidget {
  WorkMobile({
    Key? key,
  }) : super(key: key);

  @override
  _WorkTabletState createState() => _WorkTabletState();
}

class _WorkTabletState extends State<WorkMobile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        // height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("MOBILE"),
              Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: width / 2,
                  height: height / 2,
                  color: Colors.black26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                ),
              ),
              // ParallaxMenu()
            ],
          ),
        ));
  }
}
