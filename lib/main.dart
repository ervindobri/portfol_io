import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:portfol_io/constants/theme.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/main_page.dart';
import 'package:flutter/gestures.dart';

Future<void> main() async {
  Paint.enableDithering = true;
  // Right before you would be doing any loading
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  sl<UiShowcaseManager>().itemsCommand.execute();

  runApp(MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Ervin Dobri',
        theme: PortfolioTheme.theme,
        scrollBehavior: MyCustomScrollBehavior(),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
      ),
    );
  }
}
