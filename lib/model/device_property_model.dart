class DevicePropertyModel {
  String id;
  String name;
  String brand;
  String image;
  bool deviceStatus;
  int deviceBatteryHealth;
  int deviceChargePercentage;

  DevicePropertyModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.deviceStatus,
    required this.deviceBatteryHealth,
    required this.deviceChargePercentage,
  });

  factory DevicePropertyModel.fromJson(Map<String, dynamic> json) {
    return DevicePropertyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      image: json['image'] ?? '',
      deviceStatus: json['deviceStatus'] ?? '',
      deviceBatteryHealth: json['deviceBatteryHealth'] ?? '',
      deviceChargePercentage: json['deviceChargePercentage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'image': image,
      'deviceStatus': deviceStatus,
      'deviceBatteryHealth': deviceBatteryHealth,
      'deviceChargePercentage': deviceChargePercentage,
    };
  }
}
