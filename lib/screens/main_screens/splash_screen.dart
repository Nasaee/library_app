import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/screens/main_screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasLoaded = false;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasLoaded) {
      _hasLoaded = true;
      _preloadImageAndNavigate();
    }
  }

  void _preloadImageAndNavigate() async {
    // Start image preloading but don't block UI
    precacheImage(const AssetImage('assets/images/bg.jpg'), context).then((_) {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
        });
      }
    });

    // Wait for 3 seconds before navigating
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.goNamed(MainScreen.routeName);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Only show when loaded)
          if (_isImageLoaded)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              child: Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            )
          else
            Container(
                color: Colors.black), // Show black background while loading

          // Centered Content (Always Visible)
          Positioned(
            top: 200,
            right: 30,
            left: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(Icons.menu_book_outlined,
                    size: 100, color: Colors.amber[400]),
                const SizedBox(height: 20),
                Text(
                  'Albrain Books',
                  style: TextStyle(
                    color: Colors.amber[500],
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your Personal Library',
                  style: TextStyle(
                    color: Colors.amber[400],
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 50),
                CircularProgressIndicator(color: Colors.amber[800]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
