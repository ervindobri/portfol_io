import 'package:get_it/get_it.dart';
import 'package:portfol_io/manager/menu_manager.dart';

final sl = GetIt.instance;

init() {
  sl.registerLazySingleton<UiMenuManager>(
    () => UiMenuManager(),
  );
}
