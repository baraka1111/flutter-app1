import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:test_app/contact.dart';
import 'package:test_app/home.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/tasks.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabs'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.note), text: "My Task"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
              Tab(icon: Icon(Icons.contact_mail), text: "Contact"),
            ],
          ),
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
