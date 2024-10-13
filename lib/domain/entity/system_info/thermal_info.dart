class ThermalInfo{
  final String battery;
  ThermalInfo({required this.battery});

  factory ThermalInfo.fromJson(Map<String, dynamic> json) {
    return ThermalInfo(
        battery: json['Battery'] as String
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Battery": battery,
    };
  }


}
