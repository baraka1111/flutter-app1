import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const SScreen(),
    );
  }
}

class SScreen extends StatefulWidget {
  const SScreen({super.key});

  @override
  State<SScreen> createState() => _SScreenState();
}

class _SScreenState extends State<SScreen> {
  bool cellularData = true;
  bool wifi = true;
  bool singleCheck = false;
  bool allowNotifications = true;
  bool turnOffNotifications = false;
  bool multipleCheck = false;
  bool microphoneAccess = true;
  bool locationAccess = true;
  bool haptics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Toggle',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              _buildToggleItem('Cellular data', cellularData, (value) {
                setState(() {
                  cellularData = value;
                });
              }),
              _buildToggleItem('Wi-Fi', wifi, (value) {
                setState(() {
                  wifi = value;
                });
              }),
              _buildToggleItem('Single check', singleCheck, (value) {
                setState(() {
                  singleCheck = value;
                });
              }),
              _buildToggleItem('Allow notifications', allowNotifications, (value) {
                setState(() {
                  allowNotifications = value;
                });
              }),
              _buildToggleItem('Turn off notifications', turnOffNotifications, (value) {
                setState(() {
                  turnOffNotifications = value;
                });
              }),
              _buildToggleItem('Multiple check', multipleCheck, (value) {
                setState(() {
                  multipleCheck = value;
                });
              }),
              _buildToggleItem('Microphone access', microphoneAccess, (value) {
                setState(() {
                  microphoneAccess = value;
                });
              }),
              _buildToggleItem('Location access', locationAccess, (value) {
                setState(() {
                  locationAccess = value;
                });
              }),
              _buildToggleItem('Haptics', haptics, (value) {
                setState(() {
                  haptics = value;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleItem(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}