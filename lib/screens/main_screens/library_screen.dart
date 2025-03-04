import 'package:flutter/material.dart';
import 'package:library_app/constants/theme.dart';

class LibraryScreen extends StatefulWidget {
  static const String routeName = '/library';
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Center(
            child: Text('Library Screen'),
          ),
        ),
      ),
    );
  }
}
