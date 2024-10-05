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
  String toString() {
    return '''
batteryInfo: ${batteryInfo}
    ''';
  }
}
