// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class loginScreen extends StatefulWidget{
  @override
  State<loginScreen> createState() => _loginScreenState();
}
 class _loginScreenState extends State<loginScreen> {
  File? _image;
  String _name = "John Doe";
  String _password = "123 456 7890";

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _loginProfile() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController =
            TextEditingController(text: _name);
        TextEditingController passwordController =
            TextEditingController(text: _password);

        return AlertDialog(
          title: Text("Create Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Username")),
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = nameController.text;
                  _password = passwordController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            InkWell(
              onTap: _pickImage,
              child: ClipOval(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: _image != null
                      ? Image.file(_image!,
                          width: 120, height: 120, fit: BoxFit.cover)
                      : Icon(Icons.person, size: 80, color: Colors.grey[700]),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.image),
              label: Text("Add Profile Picture"),
            ),
            SizedBox(height: 20),

            // User Details
            _buildDetail("Userame", _name),
            _buildDetail("password", _password),

            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loginProfile,
              icon: Icon(Icons.edit),
              label: Text("Log In"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value, style: TextStyle(fontSize: 16)),
        ),
        SizedBox(height: 15),
      ],
    );
  }
  }
