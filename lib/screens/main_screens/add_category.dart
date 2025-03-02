import 'package:flutter/material.dart';

class AddCategoryScreen extends StatelessWidget {
  static const String routeName = '/add_category';
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('Add Category Screen'),
      ),
    );
  }
}
