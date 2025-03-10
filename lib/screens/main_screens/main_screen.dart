import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/screens/main_screens/add_category.dart';
import 'package:library_app/screens/main_screens/home_screen.dart';
import 'package:library_app/screens/main_screens/search_screen.dart';
import 'package:library_app/screens/main_screens/library_screen.dart';
import 'package:library_app/screens/main_screens/add_book_screen.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main';
  final Widget child; // 👈 Receives active page from ShellRoute

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child, // 👈 Displays the active page
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white, // Add background color
          currentIndex: _getCurrentIndex(context),
          onTap: (index) => _onTabTapped(index, context),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_rounded), label: 'Add Book'),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), label: 'Library'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_card), label: 'Add Category'),
          ],
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location == HomeScreen.routeName) return 0;
    if (location == SearchScreen.routeName) return 1;
    if (location == AddBookScreen.routeName) return 2; // ✅ Match full route
    if (location == LibraryScreen.routeName) return 3;
    if (location == AddCategoryScreen.routeName) return 4; // ✅ Match full route

    return 0; // Default is Home
  }

  void _onTabTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(HomeScreen.routeName);
        break;
      case 1:
        context.goNamed(SearchScreen.routeName);
        break;
      case 2:
        context.goNamed(AddBookScreen.routeName);

        break;
      case 3:
        context.goNamed(LibraryScreen.routeName);
        break;
      case 4:
        context.goNamed(AddCategoryScreen.routeName);
        break;
    }
  }
}
