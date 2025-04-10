import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logoutDialog() {
    // ignore: prefer_typing_uninitialized_variables
    var context2;
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Are you sure you want to log out from this app?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Log Out"),
            ),
          ],
        );
      }, context: context2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Change Theme"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.notification_add),
            title: Text("Enable notifications"),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Manage Account"),
            trailing: Icon(Icons.more_vert),
          ),
          GestureDetector(
            onTap: () {
              _logoutDialog();
            },
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
              trailing: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
    );
  }
}
