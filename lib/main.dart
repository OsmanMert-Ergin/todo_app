import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do Öğretici Uygulama',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
