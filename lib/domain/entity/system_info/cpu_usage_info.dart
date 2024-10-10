class CpuUsageInfo {
  String processor;
  String bogoMIPS;
  String features;
  String cpuImplementer;
  String cpuArchitecture;
  String cpuVariant;
  String cpuPart;
  String cpuRevision;
  String hardware;
  String architecture;
  String revision;
  String process;
  String clockSpeed;
  String cores;
  String cpuLoad;
  Map<String, dynamic> coreSpeeds; // Dynamic core speeds
  String gpuVendor;
  String gpuRenderer;
  String gpuLoad;

  CpuUsageInfo({
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
    required this.coreSpeeds, // Dynamic core speeds
    required this.gpuVendor,
    required this.gpuRenderer,
    required this.gpuLoad,
  });

  factory CpuUsageInfo.fromJson(Map<String, dynamic> json) {
    // Extract the core speeds dynamically (CPU 0, CPU 1, etc.)
    Map<String, dynamic> coreSpeeds = {};
    print('check for each work without side  $json');

    json.forEach((key, value) {
      print('check for each work key $key and value $value');

      // Check if the key starts with 'CPU ' and try to parse the value as a double
      if (key.startsWith('CPU ') &&
          value is String &&
          key != 'CPU architecture' &&
          key != 'CPU revision' &&
          key != 'CPU implementer' &&
          key != 'CPU variant' &&
          key != 'CPU part' &&
          key != 'CPU Usage' &&
          key != 'CPU Load'
      ) {
        coreSpeeds[key] = value;

        // Extract numeric part of the string
        //   String numericValue = value.split(' ').first;
        //
        //   // Convert the numeric value to double if possible
        //   double? parsedValue = double.tryParse(numericValue);
        //
        //   if (parsedValue != null) {
        //     print('Adding $key: $parsedValue to coreSpeeds');
        //   } else {
        //     print('Unable to parse $value as double');
        //   }
      }
    });

    return CpuUsageInfo(
      processor: json["processor"] as String,
      bogoMIPS: json["BogoMIPS"] as String,
      features: json["Features"] as String,
      cpuImplementer: json["CPU implementer"] as String,
      cpuArchitecture: json["CPU architecture"] as String,
      cpuVariant: json["CPU variant"] as String,
      cpuPart: json["CPU part"] as String,
      cpuRevision: json["CPU revision"] as String,
      hardware: json["Hardware"] as String,
      architecture: json["Architecture"] as String,
      revision: json["Revision"] as String,
      process: json["Process"] as String,
      clockSpeed: json["Clock Speed"] as String,
      cores: json["Cores"] as String,
      cpuLoad: json["CPU Load"] as String,
      coreSpeeds: coreSpeeds,
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

    // Add each core speed to the JSON object
    coreSpeeds.forEach((key, value) {
      json[key] = value;
    });

    return json;
  }
}
