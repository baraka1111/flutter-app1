import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/home.dart';
import 'package:test_app/provider/todo_provider.dart';
import 'package:test_app/tab_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()..loadTodos()),
       
      ],
      child: const MyApp(),
    ),
  );

  print(1 * 8);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabScreen(),
    );
  }
}
