import 'package:flutter/material.dart';
import 'package:portfol_io/constants/theme.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/main_page.dart';

Future<void> main() async {
  Paint.enableDithering = true;
  // Right before you would be doing any loading
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  sl<UiShowcaseManager>().itemsCommand.execute();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // var homeController = Get.put(HomeController())!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortfolIO',
      theme: PortfolioTheme.theme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
    );
  }
}
