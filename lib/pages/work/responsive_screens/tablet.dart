import 'package:flutter/material.dart';

class WorkTablet extends StatefulWidget {
  const WorkTablet({
    super.key,
  });

  @override
  WorkTabletState createState() => WorkTabletState();
}

class WorkTabletState extends State<WorkTablet> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        // height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("TABLET"),
              Container(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: width / 2,
                  height: height / 2,
                  color: Colors.black26,
                  child: const Column(
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
