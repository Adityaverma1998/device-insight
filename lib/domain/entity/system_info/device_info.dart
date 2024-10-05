class DeviceInfo {
  String model;
  String manufacturer;
  String brand;
  String board;
  String hardware;
  double screenSize;
  String screenResolution;
  int screenDensity;
  int totalRAM;
  int availableRAM;
  double totalInternalStorage;
  double availableInternalStorage;
  double totalExternalStorage;
  double availableExternalStorage;

  DeviceInfo({
    required this.model,
    required this.manufacturer,
    required this.brand,
    required this.board,
    required this.hardware,
    required this.screenSize,
    required this.screenResolution,
    required this.screenDensity,
    required this.totalRAM,
    required this.availableRAM,
    required this.totalInternalStorage,
    required this.availableInternalStorage,
    required this.totalExternalStorage,
    required this.availableExternalStorage,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      model: json["Model"] as String,
      manufacturer: json["Manufacturer"] as String,
      brand: json["Brand"] as String,
      board: json["Board"] as String,
      hardware: json["Hardware"] as String,
      screenSize: (json["ScreenSize"] as num).toDouble(),
      screenResolution: json["ScreenResolution"] as String,
      screenDensity: json["ScreenDensity"] as int,
      totalRAM: json["TotalRAM"] as int,
      availableRAM: json["AvailableRAM"] as int,
      totalInternalStorage: (json["TotalInternalStorage"] as num).toDouble(),
      availableInternalStorage: (json["AvailableInternalStorage"] as num).toDouble(),
      totalExternalStorage: (json["TotalExternalStorage"] as num).toDouble(),
      availableExternalStorage: (json["AvailableExternalStorage"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Model": model,
      "Manufacturer": manufacturer,
      "Brand": brand,
      "Board": board,
      "Hardware": hardware,
      "ScreenSize": screenSize,
      "ScreenResolution": screenResolution,
      "ScreenDensity": screenDensity,
      "TotalRAM": totalRAM,
      "AvailableRAM": availableRAM,
      "TotalInternalStorage": totalInternalStorage,
      "AvailableInternalStorage": availableInternalStorage,
      "TotalExternalStorage": totalExternalStorage,
      "AvailableExternalStorage": availableExternalStorage,
    };
  }
}
