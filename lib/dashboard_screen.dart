import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './model/device_property_model.dart';
import './provider/device_provider.dart';
import './widgets/card_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<DeviceProvider>(context, listen: false).getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Hata: ${snapshot.error}");
            } else {
              List<DevicePropertyModel> deviceList = snapshot.data as List<DevicePropertyModel>;
              return Container(
                margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
                child: Column(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Merhaba User',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 135,
                            child: Icon(
                              Icons.bar_chart_rounded,
                              size: 28,
                              color: Colors.indigo,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          const Center(
                            child: Text(
                              'AKILLI CİHAZLAR',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                                itemCount: deviceList.length,
                                itemBuilder: (context, index) {
                                  return CardWidget(devicePropertyModel: deviceList[index]);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 96),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: SizedBox(
          height: 72,
          width: 72,
          child: FloatingActionButton(
            onPressed: () async {
              await addDevice(context);
              setState(() {});
            },
            tooltip: 'Increment',
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text('Cihaz Ekle'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addDevice(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  TextEditingController deviceNameController = TextEditingController();
  TextEditingController deviceBrandController = TextEditingController();
  TextEditingController deviceBatteryHealthController = TextEditingController();
  TextEditingController deviceChargePercentageController = TextEditingController();
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Cihaz Ekle",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Cihazın Adını Giriniz..'),
                            controller: deviceNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cihazın adı boş bırakılamaz';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Cihazın markasını Giriniz..'),
                            controller: deviceBrandController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cihazın markası boş bırakılamaz';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Cihazın Batarya Sağlığını Giriniz..'),
                            controller: deviceBatteryHealthController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cihazın batarya sağlığı boş bırakılamaz';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Cihazın Şarjını Giriniz..'),
                            controller: deviceChargePercentageController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cihazın şarjı boş bırakılamaz';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: (formKey.currentState != null && formKey.currentState!.validate())
                      ? Colors.green[900]
                      : Colors.green[100],
                  padding: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  fixedSize: const Size(200, 50),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    DevicePropertyModel devicePropertyModel = DevicePropertyModel(
                      id: '',
                      name: deviceNameController.text,
                      brand: deviceBrandController.text,
                      image: 'assets/images/smart_lighting.png',
                      deviceStatus: true,
                      deviceBatteryHealth: int.parse(deviceBatteryHealthController.text),
                      deviceChargePercentage: int.parse(deviceChargePercentageController.text),
                    );
                    Navigator.pop(context);
                    await Provider.of<DeviceProvider>(context, listen: false).addDevice(devicePropertyModel);
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
