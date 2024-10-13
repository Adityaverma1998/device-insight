// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeviceInfoStore on _DeviceInfoStore, Store {
  late final _$batteryInfoAtom =
      Atom(name: '_DeviceInfoStore.batteryInfo', context: context);

  @override
  BatteryInfo get batteryInfo {
    _$batteryInfoAtom.reportRead();
    return super.batteryInfo;
  }

  @override
  set batteryInfo(BatteryInfo value) {
    _$batteryInfoAtom.reportWrite(value, super.batteryInfo, () {
      super.batteryInfo = value;
    });
  }

  late final _$deviceInfoAtom =
      Atom(name: '_DeviceInfoStore.deviceInfo', context: context);

  @override
  DeviceInfoEntity get deviceInfo {
    _$deviceInfoAtom.reportRead();
    return super.deviceInfo;
  }

  @override
  set deviceInfo(DeviceInfoEntity value) {
    _$deviceInfoAtom.reportWrite(value, super.deviceInfo, () {
      super.deviceInfo = value;
    });
  }

  late final _$systemInfoAtom =
      Atom(name: '_DeviceInfoStore.systemInfo', context: context);

  @override
  SystemInfo get systemInfo {
    _$systemInfoAtom.reportRead();
    return super.systemInfo;
  }

  @override
  set systemInfo(SystemInfo value) {
    _$systemInfoAtom.reportWrite(value, super.systemInfo, () {
      super.systemInfo = value;
    });
  }

  late final _$memoryInfoAtom =
      Atom(name: '_DeviceInfoStore.memoryInfo', context: context);

  @override
  MemoryInfo get memoryInfo {
    _$memoryInfoAtom.reportRead();
    return super.memoryInfo;
  }

  @override
  set memoryInfo(MemoryInfo value) {
    _$memoryInfoAtom.reportWrite(value, super.memoryInfo, () {
      super.memoryInfo = value;
    });
  }

  late final _$cpuUsageInfoAtom =
      Atom(name: '_DeviceInfoStore.cpuUsageInfo', context: context);

  @override
  CpuUsageInfo get cpuUsageInfo {
    _$cpuUsageInfoAtom.reportRead();
    return super.cpuUsageInfo;
  }

  @override
  set cpuUsageInfo(CpuUsageInfo value) {
    _$cpuUsageInfoAtom.reportWrite(value, super.cpuUsageInfo, () {
      super.cpuUsageInfo = value;
    });
  }

  late final _$displayInfoAtom =
      Atom(name: '_DeviceInfoStore.displayInfo', context: context);

  @override
  DisplayInfo get displayInfo {
    _$displayInfoAtom.reportRead();
    return super.displayInfo;
  }

  @override
  set displayInfo(DisplayInfo value) {
    _$displayInfoAtom.reportWrite(value, super.displayInfo, () {
      super.displayInfo = value;
    });
  }

  late final _$thermalInfoAtom =
      Atom(name: '_DeviceInfoStore.thermalInfo', context: context);

  @override
  ThermalInfo get thermalInfo {
    _$thermalInfoAtom.reportRead();
    return super.thermalInfo;
  }

  @override
  set thermalInfo(ThermalInfo value) {
    _$thermalInfoAtom.reportWrite(value, super.thermalInfo, () {
      super.thermalInfo = value;
    });
  }

  late final _$_DeviceInfoStoreActionController =
      ActionController(name: '_DeviceInfoStore', context: context);

  @override
  void updateBatteryInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateBatteryInfo');
    try {
      return super.updateBatteryInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateThermalInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateThermalInfo');
    try {
      return super.updateThermalInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDeviceInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateDeviceInfo');
    try {
      return super.updateDeviceInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSystemInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateSystemInfo');
    try {
      return super.updateSystemInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMemoryInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateMemoryInfo');
    try {
      return super.updateMemoryInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCpuUsageInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateCpuUsageInfo');
    try {
      return super.updateCpuUsageInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDisplayInfo(Map<String, dynamic> json) {
    final _$actionInfo = _$_DeviceInfoStoreActionController.startAction(
        name: '_DeviceInfoStore.updateDisplayInfo');
    try {
      return super.updateDisplayInfo(json);
    } finally {
      _$_DeviceInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
batteryInfo: ${batteryInfo},
deviceInfo: ${deviceInfo},
systemInfo: ${systemInfo},
memoryInfo: ${memoryInfo},
cpuUsageInfo: ${cpuUsageInfo},
displayInfo: ${displayInfo},
thermalInfo: ${thermalInfo}
    ''';
  }
}
