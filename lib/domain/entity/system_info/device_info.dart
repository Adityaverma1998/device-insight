class DeviceInfoEntity {
  String model;
  String manufacturer;
  String brand;
  String board;
  String hardware;
  String buildFingerprint;
  String androidDeviceID;
  String tags;
  String user;
  String time;
  String sdkInt;

  DeviceInfoEntity({
    required this.model,
    required this.manufacturer,
    required this.brand,
    required this.board,
    required this.hardware,
    required this.buildFingerprint,
    required this.androidDeviceID,
    required this.tags,
    required this.user,
    required this.time,
    required this.sdkInt,

  });

  factory DeviceInfoEntity.fromJson(Map<String, dynamic> json) {
    return DeviceInfoEntity(
      model: json["Model"] as String,
      manufacturer: json["Manufacturer"] as String,
      brand: json["Brand"] as String,
      board: json["Board"] as String,
      hardware: json["Hardware"] as String,
      buildFingerprint: json["BuildFingerprint"] as String,
      androidDeviceID: json["AndroidDeviceID"] as String,
      tags: json["Tags"] as String,
      user: json["User"] as String,
      time: json["Time"] as String,
      sdkInt: json["SDK_INT"] ,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Model": model,
      "Manufacturer": manufacturer,
      "Brand": brand,
      "Board": board,
      "Hardware": hardware,
      "BuildFingerprint": buildFingerprint,
      "AndroidDeviceID": androidDeviceID,
      "Tags": tags,
      "User": user,
      "Time": time,
      "SDK_INT": sdkInt,

    };
  }
}
