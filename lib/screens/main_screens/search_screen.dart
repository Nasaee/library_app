import 'package:flutter/material.dart';
import 'package:library_app/constants/theme.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Center(
            child: Text('Search Screen'),
          ),
        ),
      ),
    );
  }
}
