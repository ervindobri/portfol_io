import 'package:flutter/material.dart';

class HomeTablet extends StatefulWidget {
  HomeTablet({
    Key? key,
  }) : super(key: key);

  @override
  _HomeTabletState createState() => _HomeTabletState();
}

class _HomeTabletState extends State<HomeTablet> {
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
              Text("TABLET"),
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
