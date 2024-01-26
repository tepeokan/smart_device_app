import 'package:flutter/material.dart';
import '../device_screen.dart';
import '../model/device_property_model.dart';

class CardWidget extends StatelessWidget {
  final DevicePropertyModel devicePropertyModel;
  const CardWidget({required this.devicePropertyModel, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeviceScreen(devicePropertyModel: devicePropertyModel),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.amber,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(devicePropertyModel.image),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                devicePropertyModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
