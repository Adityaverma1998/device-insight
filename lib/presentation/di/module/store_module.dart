import 'dart:async';

import 'package:device_insight/core/store/device_info/device_info_store.dart';
import 'package:device_insight/di/serivce_locators.dart';



class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    // getIt.registerFactory(() => ErrorStore());
    // getIt.registerFactory(() => FormErrorStore());
    // getIt.registerFactory(
    //   () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    // );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<DeviceInfoStore>(
      DeviceInfoStore(),
    );

  //   getIt.registerSingleton<ThemeStore>(
  //     ThemeStore(
  //       getIt<SettingRepository>(),
  //       getIt<ErrorStore>(),
  //     ),
  //   );
  //
  //   getIt.registerSingleton<LanguageStore>(
  //     LanguageStore(
  //       getIt<SettingRepository>(),
  //       getIt<ErrorStore>(),
  //     ),
  //   );
  }
}
