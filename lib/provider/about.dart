import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text(
            "This is a to do list app version 1.1 that will help you to organise and plan your day accordingly"),
      ),
    );
  }
}
