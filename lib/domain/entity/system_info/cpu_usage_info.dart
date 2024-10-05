class CpuInfo {
  int processor;
  double bogoMIPS;
  String features;
  String cpuImplementer;
  int cpuArchitecture;
  String cpuVariant;
  String cpuPart;
  int cpuRevision;
  String hardware;
  String architecture;
  String revision;
  String process;
  String clockSpeed;
  int cores;
  double cpuLoad;
  Map<String, double> coreSpeeds; // Dynamic core speeds
  String gpuVendor;
  String gpuRenderer;
  String gpuLoad;

  CpuInfo({
    required this.processor,
    required this.bogoMIPS,
    required this.features,
    required this.cpuImplementer,
    required this.cpuArchitecture,
    required this.cpuVariant,
    required this.cpuPart,
    required this.cpuRevision,
    required this.hardware,
    required this.architecture,
    required this.revision,
    required this.process,
    required this.clockSpeed,
    required this.cores,
    required this.cpuLoad,
    required this.coreSpeeds,  // Dynamic core speeds
    required this.gpuVendor,
    required this.gpuRenderer,
    required this.gpuLoad,
  });

  factory CpuInfo.fromJson(Map<String, dynamic> json) {
    // Extract the core speeds dynamically (CPU 0, CPU 1, etc.)
    Map<String, double> coreSpeeds = {};
    json.forEach((key, value) {
      if (key.startsWith('CPU ') && value is num) {
        coreSpeeds[key] = value.toDouble();
      }
    });

    return CpuInfo(
      processor: json["processor"] as int,
      bogoMIPS: json["BogoMIPS"] as double,
      features: json["Features"] as String,
      cpuImplementer: json["CPU implementer"] as String,
      cpuArchitecture: json["CPU architecture"] as int,
      cpuVariant: json["CPU variant"] as String,
      cpuPart: json["CPU part"] as String,
      cpuRevision: json["CPU revision"] as int,
      hardware: json["Hardware"] as String,
      architecture: json["Architecture"] as String,
      revision: json["Revision"] as String,
      process: json["Process"] as String,
      clockSpeed: json["Clock Speed"] as String,
      cores: json["Cores"] as int,
      cpuLoad: json["CPU Load"] as double,
      coreSpeeds: coreSpeeds,  // Assign dynamic core speeds
      gpuVendor: json["GPU Vendor"] as String,
      gpuRenderer: json["GPU Renderer"] as String,
      gpuLoad: json["GPU Load"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "processor": processor,
      "BogoMIPS": bogoMIPS,
      "Features": features,
      "CPU implementer": cpuImplementer,
      "CPU architecture": cpuArchitecture,
      "CPU variant": cpuVariant,
      "CPU part": cpuPart,
      "CPU revision": cpuRevision,
      "Hardware": hardware,
      "Architecture": architecture,
      "Revision": revision,
      "Process": process,
      "Clock Speed": clockSpeed,
      "Cores": cores,
      "CPU Load": cpuLoad,
      "GPU Vendor": gpuVendor,
      "GPU Renderer": gpuRenderer,
      "GPU Load": gpuLoad,
    };

    json.addAll(coreSpeeds); // Add dynamic core speeds (CPU 0, CPU 1, etc.)

    return json;
  }
}
