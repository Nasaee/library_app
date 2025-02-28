import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  static const String routeName = '/add';
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Add Book Screen'),
      ),
    );
  }
}
