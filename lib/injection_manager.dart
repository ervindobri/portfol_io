import 'package:get_it/get_it.dart';
import 'package:portfol_io/managers/download_manager.dart';
import 'package:portfol_io/managers/menu_manager.dart';
import 'package:portfol_io/managers/showcase_manager.dart';

final sl = GetIt.instance;

init() {
  sl.registerLazySingleton<UiMenuManager>(
    () => UiMenuManager(),
  );
  sl.registerLazySingleton<UiShowcaseManager>(
    () => UiShowcaseManager(),
  );
  sl.registerLazySingleton<DownloadManager>(
    () => DownloadManager(),
  );
}
