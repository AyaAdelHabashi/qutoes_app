import 'package:get_it/get_it.dart';
import 'package:qutoes_app/feature/home/controller/main_controller.dart';

class ServiceLocator {
  static GetIt getIt = GetIt.instance();
  static void init() {
    getIt = GetIt.instance;
    getIt.registerSingleton<MainProvider>(MainProvider());
  }
}
