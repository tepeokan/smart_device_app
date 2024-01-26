import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import './model/device_property_model.dart';

class DeviceScreen extends StatefulWidget {
  final DevicePropertyModel devicePropertyModel;

  const DeviceScreen({required this.devicePropertyModel, super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 28, color: Colors.blue[900]),
        ),
        title: Text(
          widget.devicePropertyModel.name,
          style: TextStyle(color: Colors.blue[900], fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: RotatedBox(
              quarterTurns: 135,
              child: Icon(
                Icons.bar_chart_rounded,
                size: 28,
                color: Colors.indigo,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 12),
                    CircularPercentIndicator(
                      radius: 120,
                      lineWidth: 15,
                      percent: widget.devicePropertyModel.deviceChargePercentage / 100,
                      progressColor: Colors.blue[900],
                      center: Text(
                        '${widget.devicePropertyModel.deviceChargePercentage} %',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Şarj Durumu",
                        style: TextStyle(fontSize: 22, color: Colors.blue[900], fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Pil Sağlık Kapasitesi : ",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '% ${widget.devicePropertyModel.deviceBatteryHealth}',
                            style: const TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Cihazı Aç/Kapat : ",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
