import 'package:flutter/material.dart';
import 'package:native_accelerometer/native_accelerometer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelerometer App',
      debugShowCheckedModeBanner: false,
      home: const AccelerometerScreen(),
    );
  }
}

class AccelerometerScreen extends StatelessWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-time Accelerometer Data')),
      body: Center(
        child: StreamBuilder<Map<String, double>>(
          stream: NativeAccelerometer.accelerometerStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text('No data available');
            }

            final data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('X: ${data['x']?.toStringAsFixed(2)}'),
                Text('Y: ${data['y']?.toStringAsFixed(2)}'),
                Text('Z: ${data['z']?.toStringAsFixed(2)}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
