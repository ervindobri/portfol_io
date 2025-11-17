import 'package:flutter/material.dart';
import 'package:portfol_io/constants/globals.dart';
import 'package:portfol_io/constants/colors.dart';

typedef ScrollCallback = void Function(int);

class MenuTablet extends StatelessWidget {
  final ScrollCallback onItemTapCallback;

  const MenuTablet({
    super.key,
    required int selectedIndex,
    required this.onItemTapCallback,
  })  : _selectedIndex = selectedIndex;

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: width * .1,
                height: 100,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/logo1.png"))),
              ),
            ),
            SizedBox(
              width: width * .8,
              // color: Colors.blueAccent,
              child: Wrap(
                spacing: 8,
                runSpacing: 12,
                children: getList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getList() {
    List<Widget> list = [];
    list.addAll(List.generate(
        Globals.menu.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {
                  onItemTapCallback(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Globals.menu[index],
                      style: const TextStyle(
                        color: GlobalColors.primaryColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? GlobalColors.primaryColor
                              : Colors.transparent,
                          shape: BoxShape.circle),
                    )
                  ],
                ),
              ),
            )));
    list.add(ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(GlobalColors.primaryColor),
          shadowColor: MaterialStateProperty.all(GlobalColors.primaryColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
      onPressed: () {
        // print("button");
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          Globals.contactMe,
          style: TextStyle(
            color: GlobalColors.white,
            fontSize: 20,
          ),
        ),
      ),
    ));
    return list;
  }
}
