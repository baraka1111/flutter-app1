import 'package:flutter/material.dart';
import 'package:test_app/profile.dart';
import 'package:test_app/tab_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.menu),
      //   title: Text(
      //     "My App",
      //     style: TextStyle(fontStyle: FontStyle.italic),
      //   ),
      //   backgroundColor: Colors.blue,
      //   actions: <Widget>[
      //     IconButton(onPressed: () {}, icon: Icon(Icons.search))
      //   ],
      // ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.person),
              Text("My name"),
              Text("My name"),
              Text("My name"),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabScreen()));
                  },
                  child: Icon(Icons.edit)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.person),
              Text("My name"),
              Text("My name"),
              Text("My name"),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInfoScreen()));
                  },
                  child: Icon(Icons.edit)),
            ],
          ),
        ],
      ),
    );
  }
}
