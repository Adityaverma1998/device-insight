class SystemInfo {
  int androidVersion;
  int apiLevel;
  String securityPatchLevel;
  String bootloader;
  String buildID;
  String javaVM;
  String? openGLES;
  String kernelArchitecture;
  String kernelVersion;
  bool rootAccess;
  bool googlePlayServices;
  int systemUptime;

  SystemInfo({
    required this.androidVersion,
    required this.apiLevel,
    required this.securityPatchLevel,
    required this.bootloader,
    required this.buildID,
    required this.javaVM,
    this.openGLES,
    required this.kernelArchitecture,
    required this.kernelVersion,
    required this.rootAccess,
    required this.googlePlayServices,
    required this.systemUptime,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      androidVersion: json["AndroidVersion"] as int,
      apiLevel: json["ApiLevel"] as int,
      securityPatchLevel: json["SecurityPatchLevel"] as String,
      bootloader: json["Bootloader"] as String,
      buildID: json["BuildID"] as String,
      javaVM: json["JavaVM"] as String,
      openGLES: json["OpenGL_ES"] as String?,
      kernelArchitecture: json["KernelArchitecture"] as String,
      kernelVersion: json["KernelVersion"] as String,
      rootAccess: json["RootAccess"] as bool,
      googlePlayServices: json["GooglePlayServices"] as bool,
      systemUptime: json["SystemUptime"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AndroidVersion": androidVersion,
      "ApiLevel": apiLevel,
      "SecurityPatchLevel": securityPatchLevel,
      "Bootloader": bootloader,
      "BuildID": buildID,
      "JavaVM": javaVM,
      "OpenGL_ES": openGLES,
      "KernelArchitecture": kernelArchitecture,
      "KernelVersion": kernelVersion,
      "RootAccess": rootAccess,
      "GooglePlayServices": googlePlayServices,
      "SystemUptime": systemUptime,
    };
  }
}
