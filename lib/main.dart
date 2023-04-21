import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion/motion.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:portfol_io/injection_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';
import 'package:portfol_io/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:portfol_io/providers/providers.dart';

Future<void> main() async {
  // Initialize the plugin.
  await Motion.instance.initialize();

  Paint.enableDithering = true;
  // Right before you would be doing any loading
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  sl<UiShowcaseManager>().itemsCommand.execute();

  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Ervin Dobri',
        theme: ref.watch(themeProvider),
        scrollBehavior: MyCustomScrollBehavior(),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
      ),
    );
  }
}
