
import 'package:device_insight/domain/entity/system_info/battery_info.dart';
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

  // Action to update the battery info from a JSON
  @action
  void updateBatteryInfo(Map<String, dynamic> json) {
    print(' check update Battery info $json');
    batteryInfo = BatteryInfo.fromJson(json);
  }

}
