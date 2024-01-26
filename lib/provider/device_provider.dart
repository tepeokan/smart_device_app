import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_devices_app/model/device_property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceProvider extends ChangeNotifier {
  Future<void> addDevice(DevicePropertyModel devicePropertyModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingModels = prefs.getStringList('devicePropertyModel') ?? [];

    existingModels.add(json.encode(devicePropertyModel.toJson()));
    prefs.setStringList('devicePropertyModel', existingModels);
    notifyListeners();
  }

  Future<List<DevicePropertyModel>> setData() async {
    List<String> setDeviceList = [];
    DevicePropertyModel deviceModelWatch = DevicePropertyModel(
      id: '1',
      name: 'Akıllı Saat',
      brand: 'Apple',
      image: 'assets/images/watch.png',
      deviceStatus: true,
      deviceBatteryHealth: 60,
      deviceChargePercentage: 60,
    );
    DevicePropertyModel deviceModelCamera = DevicePropertyModel(
        id: '2',
        name: 'Akıllı Kamera',
        brand: 'Arçelik',
        image: 'assets/images/camera.png',
        deviceStatus: true,
        deviceBatteryHealth: 40,
        deviceChargePercentage: 90);
    DevicePropertyModel deviceModelLighting = DevicePropertyModel(
        id: '3',
        name: 'Akıllı Aydınlatma',
        brand: 'Samsung',
        image: 'assets/images/smart_lighting.png',
        deviceStatus: true,
        deviceBatteryHealth: 80,
        deviceChargePercentage: 75);
    setDeviceList.addAll([
      json.encode(deviceModelWatch.toJson()),
      json.encode(deviceModelCamera.toJson()),
      json.encode(deviceModelLighting.toJson())
    ]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('devicePropertyModel', setDeviceList);

    List<String> modelStrings = prefs.getStringList('devicePropertyModel') ?? [];

    List<DevicePropertyModel> deviceList =
        modelStrings.map((modelString) => DevicePropertyModel.fromJson(json.decode(modelString))).toList();

    notifyListeners();
    return deviceList;
  }

  Future<List<DevicePropertyModel>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> modelStrings = prefs.getStringList('devicePropertyModel') ?? [];
    List<DevicePropertyModel> deviceList =
        modelStrings.map((modelString) => DevicePropertyModel.fromJson(json.decode(modelString))).toList();

    notifyListeners();
    return deviceList;
  }
}
