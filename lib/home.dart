import 'package:flutter/material.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/tab_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ClipOval(
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                child: Icon(
                  Icons.abc,
                  size: 50,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Welcome To My App",
              style: TextStyle(fontSize: 25, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
