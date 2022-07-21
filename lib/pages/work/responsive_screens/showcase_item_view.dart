import 'package:flutter/material.dart';
import 'package:portfol_io/pages/work/carousel_controller.dart';
import 'package:portfol_io/pages/work/showcase_item_widget.dart';

class ShowcaseItemView extends StatelessWidget {
  const ShowcaseItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          height: height * .8 - 96 - 32 - 32,
          // color: GlobalColors.lightGrey.withOpacity(.4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: AnimatedShowcaseItemWidget(),
          ),
        ),
        SizedBox(height: 16),
        CarouselController(),
      ],
    );
  }
}

class MobileShowcaseItemView extends StatelessWidget {
  const MobileShowcaseItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SizedBox(
        width: width,
        child: MobileAnimatedShowcaseItemWidget(),
      ),
    );
  }
}
