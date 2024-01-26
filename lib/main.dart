import 'package:flutter/material.dart';
import 'package:flutter_smart_devices_app/dashboard_screen.dart';
import 'package:flutter_smart_devices_app/provider/device_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _setDataAsync();
  }

  Future<void> _setDataAsync() async {
    await Provider.of<DeviceProvider>(context, listen: false).setData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DeviceProvider>(context, listen: false).setData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 80,
        title: const Text(
          'HOŞGELDİNİZ..',
          style: TextStyle(
            fontSize: 26,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const DashboardScreen(),
    );
  }
}
