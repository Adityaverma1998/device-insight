
import 'package:device_insight/domain/entity/system_info/battery_info.dart';
import 'package:device_insight/domain/entity/system_info/device_info.dart';
import 'package:mobx/mobx.dart';

part 'device_info_store.g.dart';

class DeviceInfoStore = _DeviceInfoStore with _$DeviceInfoStore;

abstract class _DeviceInfoStore with Store {
  _DeviceInfoStore();

  @observable
  BatteryInfo batteryInfo = BatteryInfo(
    batteryPercentage: "Unknown",
    batteryTemperature: "Unknown",
    batteryVoltage: "Unknown",
    batteryHealth: "Unknown",
    batteryPowerSource: "Unknown",
    batteryStatus: "Unknown",
    batteryTechnology: "Unknown", batteryCurrent: 'Unknown', batteryCapacity: 'Unknown',
  );

  @observable
  DeviceInfoEntity deviceInfo = DeviceInfoEntity(
    model: 'Unknown',
    manufacturer: 'Unknown',
    brand: 'Unknown',
    board: 'Unknown',
    hardware: 'Unknown',
    buildFingerprint: 'Unknown',
    androidDeviceID: 'Unknown',
    tags: 'Unknown',
    user: 'Unknown',
    time: 'Unknown',
    sdkInt: "Unknown", // This remains null
  );

  // Action to update the battery info from a JSON
  @action
  void updateBatteryInfo(Map<String, dynamic> json) {
    print(' check update Battery info $json');
    batteryInfo = BatteryInfo.fromJson(json);
  }
  @action
  void updateSystemInfo(Map<String, dynamic> json) {
    print(' check update system info store  info $json');
    deviceInfo = DeviceInfoEntity.fromJson(json);
  }

}
