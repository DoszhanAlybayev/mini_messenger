import 'package:flutter/material.dart';
import 'package:mini_messenger/pages/login_page.dart';

void main() {
  runApp(const MiniMessengerApp());
}

class MiniMessengerApp extends StatelessWidget {
  const MiniMessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Messenger',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
