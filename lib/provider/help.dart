import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Help & support"),
          backgroundColor: Colors.amber,
        ),
        body: ListView(children: [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Contact Us with Office Number"),
            subtitle: Text("123456789"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.web),
            title: Text("Our Website"),
            subtitle: Text("www.example.com"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email Address:"),
            subtitle: Text("example@gmail.com"),
            trailing: Icon(Icons.more_vert),
          ),
        ]));
  }
}
