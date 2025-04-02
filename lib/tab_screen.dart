import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:test_app/contact.dart';
import 'package:test_app/home.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/provider/about.dart';
import 'package:test_app/provider/help.dart';
import 'package:test_app/provider/settings.dart';
import 'package:test_app/tasks.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.note), text: "My Task"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
              Tab(icon: Icon(Icons.contact_mail), text: "Contact"),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'settings') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                } else if (value == 'help') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                } else if (value == 'about') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: 'settings', child: Text('Settings')),
                  PopupMenuItem(value: 'help', child: Text('Help')),
                  PopupMenuItem(value: 'about', child: Text('About This App')),
                ];
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            HomePage(),
            MyTasksScreen(),
            ProfileInfoScreen(),
            ContactScreen(),
          ],
        ),
      ),
    );
  }
}
