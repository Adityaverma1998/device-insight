class SystemInfo {
  String androidVersion; // Changed to String to match the JSON
  String apiLevel;
  String securityPatchLevel;
  String buildID;
  String bootloader; // Added this field since it was in your original class but not in the JSON. Remove if unnecessary.
  String javaVM;
  String? openGLES;
  String kernelArchitecture;
  String kernelVersion;
  bool rootAccess;
  String language; // Added to match the JSON
  String timeZone;  // Added to match the JSON
  String systemUptime; // Changed to String to match the JSON
  bool systemAsRoot; // Added to match the JSON
  bool seamlessUpdates; // Added to match the JSON
  bool dynamicPartition; // Added to match the JSON
  bool projectTreble; // Added to match the JSON

  SystemInfo({
    required this.androidVersion,
    required this.apiLevel,
    required this.securityPatchLevel,
    required this.buildID,
    required this.bootloader,
    required this.javaVM,
    this.openGLES,
    required this.kernelArchitecture,
    required this.kernelVersion,
    required this.rootAccess,
    required this.language,
    required this.timeZone,
    required this.systemUptime,
    required this.systemAsRoot,
    required this.seamlessUpdates,
    required this.dynamicPartition,
    required this.projectTreble,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      androidVersion: json["AndroidVersion"] as String, // Updated to String
      apiLevel: json["ApiLevel"] as String,
      securityPatchLevel: json["SecurityPatchLevel"] as String,
      buildID: json["BuildID"] as String,
      bootloader: json["Bootloader"] as String, // Ensure this key exists in the JSON if needed
      javaVM: json["JavaVM"] as String,
      openGLES: json["OpenGLES"] as String?,
      kernelArchitecture: json["KernelArchitecture"] as String,
      kernelVersion: json["KernelVersion"] as String,
      rootAccess: json["RootAccess"] as bool,
      language: json["Language"] as String, // Added
      timeZone: json["TimeZone"] as String, // Added
      systemUptime: json["SystemUptime"] as String, // Updated to String
      systemAsRoot: json["SystemAsRoot"] as bool, // Added
      seamlessUpdates: json["SeamlessUpdates"] as bool, // Added
      dynamicPartition: json["DynamicPartition"] as bool, // Added
      projectTreble: json["ProjectTreble"] as bool, // Added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AndroidVersion": androidVersion,
      "ApiLevel": apiLevel,
      "SecurityPatchLevel": securityPatchLevel,
      "BuildID": buildID,
      "Bootloader": bootloader, // Ensure this key exists in the JSON if needed
      "JavaVM": javaVM,
      "OpenGLES": openGLES,
      "KernelArchitecture": kernelArchitecture,
      "KernelVersion": kernelVersion,
      "RootAccess": rootAccess,
      "Language": language, // Added
      "TimeZone": timeZone, // Added
      "SystemUptime": systemUptime, // Updated to String
      "SystemAsRoot": systemAsRoot, // Added
      "SeamlessUpdates": seamlessUpdates, // Added
      "DynamicPartition": dynamicPartition, // Added
      "ProjectTreble": projectTreble, // Added
    };
  }
}
