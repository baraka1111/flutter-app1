import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.amber,
      leading: Icon(Icons.menu),
      title: Text("Topics"),
    ),
    body: ListView(children: [
          ListTile(
            leading: Icon(Icons.theater_comedy),
            title: Text("Attractions"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text("Dining"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("Education"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.monitor_heart_sharp),
            title: Text("Health"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Family"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text("Work"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.airplane_ticket),
            title: Text("Travel"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text("Sports"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.campaign),
            title: Text("Promo"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.radio),
            title: Text("Radio"),
            trailing: Icon(Icons.more_vert),
          )
        ])
    );
  }

}