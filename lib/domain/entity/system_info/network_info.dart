class NetworkInfo {
  String carrierName;
  String networkType;
  String phoneNumber;
  String signalStrength;

  NetworkInfo({
    required this.carrierName,
    required this.networkType,
    required this.phoneNumber,
    required this.signalStrength,
  });

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      carrierName: json["carrierName"] as String,
      networkType: json["networkType"] as String,
      phoneNumber: json["phoneNumber"] as String,
      signalStrength: json["signalStrength"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "carrierName": carrierName,
      "networkType": networkType,
      "phoneNumber": phoneNumber,
      "signalStrength": signalStrength,
    };
  }
}
