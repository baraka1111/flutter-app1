import 'package:flutter/material.dart';
import 'package:test_app/contact.dart';
import 'package:test_app/home.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/provider/about.dart';
import 'package:test_app/provider/help.dart';
import 'package:test_app/provider/login.dart';
import 'package:test_app/provider/moresettings.dart';
import 'package:test_app/provider/my_tasks_screen.dart';
import 'package:test_app/provider/settings.dart';
import 'package:test_app/provider/topic.dart';
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
                } else if (value =='log in') {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => loginScreen()));
                } else if (value =='more settings') {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => MyApp()));
                } else if (value =='Topic') {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TopicScreen()));
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: 'settings', child: Text('Settings')),
                  PopupMenuItem(value: 'help', child: Text('Help')),
                  PopupMenuItem(value: 'about', child: Text('About This App')),
                  PopupMenuItem(value: 'more settings', child: Text('More Settings')),
                  PopupMenuItem(value: 'log in', child: Text('Log in')),
                  PopupMenuItem(value: 'Topic', child: Text('Topic'))
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
