import 'package:device_insight/presentation/di/presentation_layer_injection.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {

  static Future<void> configureDependencies() async {

    await PresentationLayerInjection.configurePresentationLayerInjection();
  }
}
