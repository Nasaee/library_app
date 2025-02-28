import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTabTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Book'),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(LibraryScreen.routeName)) return 2;
    if (location.startsWith(SearchScreen.routeName)) return 1;
    if (location.startsWith(AddBookScreen.routeName)) return 3;
    return 0; // Default is Home
  }

  void _onTabTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(HomeScreen.routeName);
        break;
      case 1:
        context.go(SearchScreen.routeName);
        break;
      case 2:
        context.go(LibraryScreen.routeName);
        break;
      case 3:
        context.go(AddBookScreen.routeName);
        break;
    }
  }
}
