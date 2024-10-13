class DisplayInfo {
  final String resolution;
  final String density;
  final String fontScale;
  final String refreshRate;
  final String orientation;
  final String brightnessLevel;
  final String brightnessMode;
  final String hdrCapabilities;
  final String screenTimeout;
  final String screenSize;

  DisplayInfo({
    required this.resolution,
    required this.density,
    required this.fontScale,
    required this.refreshRate,
    required this.orientation,
    required this.brightnessLevel,
    required this.brightnessMode,
    required this.hdrCapabilities,
    required this.screenTimeout,
    required this.screenSize,
  });

  // You can also add factory methods or fromJson if necessary
  factory DisplayInfo.fromJson(Map<String, dynamic> json) {
    return DisplayInfo(
      resolution: json['Resolution'] as String,
      density: json['Density'] as String,
      fontScale: json['FontScale'] as String,
      refreshRate: json['RefreshRate'] as String,
      orientation: json['Orientation'] as String,
      brightnessLevel: json['BrightnessLevel'] as String,
      brightnessMode: json['BrightnessMode'] as String,
      hdrCapabilities: json['HDRCapabilities'] as String,
      screenTimeout: json['ScreenTimeout'] as String,
      screenSize: json['ScreenSize'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Resolution': resolution,
      'Density': density,
      'FontScale': fontScale,
      'RefreshRate': refreshRate,
      'Orientation': orientation,
      'BrightnessLevel': brightnessLevel,
      'BrightnessMode': brightnessMode,
      'HDRCapabilities': hdrCapabilities,
      'ScreenTimeout': screenTimeout,
      'ScreenSize': screenSize,
    };
  }
}
