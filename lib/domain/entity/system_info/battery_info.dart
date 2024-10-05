class BatteryInfo {
  String batteryPercentage;
  String batteryTemperature;
  String batteryVoltage;
  String batteryHealth;
  String batteryPowerSource;
  String batteryStatus;
  String batteryTechnology;
  String batteryCurrent;
  String batteryCapacity;

  BatteryInfo({
    required this.batteryPercentage,
    required this.batteryTemperature,
    required this.batteryVoltage,
    required this.batteryHealth,
    required this.batteryPowerSource,
    required this.batteryStatus,
    required this.batteryTechnology,
    required this.batteryCurrent,
    required this.batteryCapacity,
  });

  // Factory method to create a BatteryInfo instance from JSON
  factory BatteryInfo.fromJson(Map<String, dynamic> json) {
    return BatteryInfo(
      batteryPercentage: json["BatteryLevel"] as String,
      batteryTemperature: json["Temperature"] as String,
      batteryVoltage: json["Voltage"] as String,
      batteryHealth: json["BatteryHealth"] as String,
      batteryPowerSource: json["BatteryPowerSource"] as String,
      batteryStatus: json["BatteryStatus"] as String,
      batteryTechnology: json["Technology"] as String,
      batteryCurrent: json["BatteryCurrent"] as String,
      batteryCapacity: json["BatteryCapacity"] as String,
    );
  }

  // Method to convert BatteryInfo to a JSON map
  Map<String, dynamic> toJson() {
    return {
      "BatteryLevel": batteryPercentage,
      "Temperature": batteryTemperature,
      "Voltage": batteryVoltage,
      "BatteryHealth": batteryHealth,
      "BatteryPowerSource": batteryPowerSource,
      "BatteryStatus": batteryStatus,
      "Technology": batteryTechnology,
      "BatteryCurrent": batteryCurrent,
      "BatteryCapacity": batteryCapacity,
    };
  }
}
