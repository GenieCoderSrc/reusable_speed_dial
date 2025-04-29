import 'package:flutter/material.dart';
import 'package:reusable_speed_dial/reusable_speed_dial.dart';
import 'package:reusable_speed_dial/speed_dial_child.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reusable Speed Dial Example',
      home: const SpeedDialExample(),
    );
  }
}

class SpeedDialExample extends StatelessWidget {
  const SpeedDialExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speed Dial Demo')),
      body: const Center(child: Text('Tap the FAB to open Speed Dial')),
      floatingActionButton: SpeedDial(
        onOpenIcon: Icons.menu,
        onCloseIcon: Icons.close,
        speedDialChildren: [
          SpeedDialChild(
            child: const Icon(Icons.message),
            label: 'Message',
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () => debugPrint('Message tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.mail),
            label: 'Email',
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onPressed: () => debugPrint('Email tapped'),
          ),
        ],
      ),
    );
  }
}
