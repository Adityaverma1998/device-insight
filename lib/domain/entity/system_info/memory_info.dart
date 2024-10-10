class MemoryInfo {
  String availableRam;
  String totalRam;
  String usedRam;
  String availableStorage;
  String internalStorage;
  String ramBrand;
  String ramType;
  String technology;
  bool lowMemory;

  MemoryInfo({
    required this.availableRam,
    required this.totalRam,
    required this.usedRam,
    required this.availableStorage,
    required this.internalStorage,
    required this.ramBrand,
    required this.ramType,
    required this.technology,
    required this.lowMemory,
  });

  factory MemoryInfo.fromJson(Map<String, dynamic> json) {
    return MemoryInfo(
      availableRam: json["AvailableMemory"] as String? ?? '',
      totalRam: json["TotalMemory"] as String? ?? '',
      usedRam: json["UsedMemory"] as String? ?? '',
      availableStorage: json["AvailableInternalStorage"] as String? ?? '',
      internalStorage: json["TotalInternalStorage"] as String? ?? '',
      ramBrand: json["RAMBrandName"] as String? ?? '',
      ramType: json["RAMType"] as String? ?? '',
      technology: json["RAMTechnology"] as String? ?? '',
      lowMemory: json["LowMemory"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AvailableMemory": availableRam,
      "TotalMemory": totalRam,
      "UsedMemory": usedRam,
      "AvailableInternalStorage": availableStorage,
      "TotalInternalStorage": internalStorage,
      "RAMBrandName": ramBrand,
      "RAMType": ramType,
      "RAMTechnology": technology,
      "LowMemory": lowMemory,
    };
  }
}
