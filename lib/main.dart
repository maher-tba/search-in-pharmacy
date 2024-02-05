import 'package:flutter/material.dart';
import 'package:search_in_pharmacy/screens/login_page.dart';
import 'package:search_in_pharmacy/services/locator.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
