import 'package:flutter/material.dart';
import 'package:library_app/constants/theme.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Center(
            child: Text('Home Screen'),
          ),
        ),
      ),
    );
  }
}
