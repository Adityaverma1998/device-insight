import 'package:device_insight/domain/entity/system_info/battery_info.dart';
import 'package:device_insight/domain/entity/system_info/cpu_usage_info.dart';
import 'package:device_insight/domain/entity/system_info/device_info.dart';
import 'package:device_insight/domain/entity/system_info/display_info.dart';
import 'package:device_insight/domain/entity/system_info/memory_info.dart';
import 'package:device_insight/domain/entity/system_info/system_info.dart';
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
    batteryTechnology: "Unknown",
    batteryCurrent: 'Unknown',
    batteryCapacity: 'Unknown',
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
  @observable
  SystemInfo systemInfo = SystemInfo(

      openGLES: 'Unknown',
      androidVersion: 'Unknown',
      apiLevel: "Unknown",
      securityPatchLevel: 'Unknown',
      buildID: 'Unknown',
      bootloader: 'Unknown',
      javaVM: 'Unknown',
      kernelArchitecture: 'Unknown',
      kernelVersion: 'Unknown',
      rootAccess: false,
      language: 'Unknown',
      timeZone: 'Unknown',
      systemUptime: 'Unknown',
      systemAsRoot: false,
      seamlessUpdates: false,
      dynamicPartition: false,
      projectTreble: false);

  @observable
  MemoryInfo memoryInfo = MemoryInfo(availableRam: "Unknown",
      totalRam: 'Unknown',
      usedRam: 'Unknown',
      availableStorage: 'Unknown',
      internalStorage: 'Unknown',
      ramBrand: 'Unknown',
      ramType: 'Unknown',
      technology: 'Unknown',
      lowMemory: false);

  @observable
  CpuUsageInfo cpuUsageInfo = CpuUsageInfo(processor: "Unknown",
      bogoMIPS: "Unknown",
      features: "Unknown",
      cpuImplementer: "Unknown",
      cpuArchitecture: "Unknown",
      cpuVariant: "Unknown",
      cpuPart: "Unknown",
      cpuRevision: "Unknown",
      hardware: "Unknown",
      architecture: "Unknown",
      revision: "Unknown",
      process: "Unknown",
      clockSpeed: "Unknown",
      cores: "Unknown",
      cpuLoad: "Unknown",
      coreSpeeds: {},
      gpuVendor: "Unknown",
      gpuRenderer: "Unknown",
      gpuLoad: "Unknown");

  @observable
  DisplayInfo displayInfo = DisplayInfo(resolution: "Unknown",
      density: "Unknown",
      fontScale: "Unknown",
      refreshRate: "Unknown",
      orientation: "Unknown",
      brightnessLevel: "Unknown",
      brightnessMode: "Unknown",
      hdrCapabilities: "Unknown",
      screenTimeout: "Unknown",
      screenSize: "Unknown");

  // Action to update the battery info from a JSON
  @action
  void updateBatteryInfo(Map<String, dynamic> json) {
    print(' check update Battery info $json');
    batteryInfo = BatteryInfo.fromJson(json);
  }

  @action
  void updateDeviceInfo(Map<String, dynamic> json) {
    print(' check update system info store  info $json');
    deviceInfo = DeviceInfoEntity.fromJson(json);
  }

  @action
  void updateSystemInfo(Map<String, dynamic> json) {
    print(' check update system info store  info $json');
    systemInfo = SystemInfo.fromJson(json);
  }

  @action
  void updateMemoryInfo(Map<String, dynamic> json) {
    print(' check update memory info $json');
    memoryInfo = MemoryInfo.fromJson(json);
  }

  @action
  void updateCpuUsageInfo(Map<String, dynamic> json) {
    print(' check update cpu  info $json');
    cpuUsageInfo = CpuUsageInfo.fromJson(json);
  }

  @action
  void updateDisplayInfo(Map<String, dynamic> json) {
    print(' check update cpu  info $json');
    displayInfo = DisplayInfo.fromJson(json);
  }
}
