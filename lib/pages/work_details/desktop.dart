import 'package:flutter/material.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

class WorkDetailsDesktop extends StatelessWidget {
  const WorkDetailsDesktop({
    super.key,
    required this.item,
  });

  final ShowcaseItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(item.projectName),
        const Placeholder(),
      ],
    ));
  }
}
