import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
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

  // Right before you would be doing any loading
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  sl<UiShowcaseManager>().itemsCommand.execute();

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (_) => const MyApp(), // Wrap your app
      ),
    ),
  );
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Portfolio',
        theme: ref.watch(themeProvider),
        // scrollBehavior: MyCustomScrollBehavior(),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
      ),
    );
  }
}
