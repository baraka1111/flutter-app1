import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
      title: Text(
        "Profile",
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.yellow),
      ),
      backgroundColor: Colors.orange,
      leading: Icon(
        Icons.person,
      ),
    ));
  }
}
