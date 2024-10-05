class WiFiInfo {
  String ssid;
  String bssid;
  String ipAddress;
  int rssi;
  int frequency;
  int linkSpeed;

  WiFiInfo({
    required this.ssid,
    required this.bssid,
    required this.ipAddress,
    required this.rssi,
    required this.frequency,
    required this.linkSpeed,
  });

  factory WiFiInfo.fromJson(Map<String, dynamic> json) {
    return WiFiInfo(
      ssid: json["SSID"] as String,
      bssid: json["BSSID"] as String,
      ipAddress: json["IP"] as String,
      rssi: json["RSSI"] as int,
      frequency: json["Frequency"] as int,
      linkSpeed: json["LinkSpeed"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "SSID": ssid,
      "BSSID": bssid,
      "IP": ipAddress,
      "RSSI": rssi,
      "Frequency": frequency,
      "LinkSpeed": linkSpeed,
    };
  }
}
