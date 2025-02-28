import 'package:go_router/go_router.dart';
import 'package:library_app/screens/main_screens/add_book_screen.dart';
import 'package:library_app/screens/main_screens/home_screen.dart';
import 'package:library_app/screens/main_screens/library_screen.dart';
import 'package:library_app/screens/main_screens/main_screen.dart';
import 'package:library_app/screens/main_screens/search_screen.dart';
import 'package:library_app/screens/main_screens/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),

    // ✅ ShellRoute wraps MainScreen to keep Bottom Navigation
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: MainScreen.routeName, // ✅ Now it's recognized!
          name: MainScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          name: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: SearchScreen.routeName,
          name: SearchScreen.routeName,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: LibraryScreen.routeName,
          name: LibraryScreen.routeName,
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: AddBookScreen.routeName,
          name: AddBookScreen.routeName,
          builder: (context, state) => const AddBookScreen(),
        ),
      ],
    ),
  ],
);
