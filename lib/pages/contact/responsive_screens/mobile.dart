import 'package:flutter/material.dart';

class ContactMobile extends StatefulWidget {
  ContactMobile({
    Key? key,
  }) : super(key: key);

  @override
  _ContactTabletState createState() => _ContactTabletState();
}

class _ContactTabletState extends State<ContactMobile> {
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
