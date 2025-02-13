import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha((0.5 * 255).toInt()), BlendMode.darken),
            child: Image.asset('assets/images/bg.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity),
          ),
          Positioned(
            top: 200,
            right: 30,
            left: 30,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Add some space at the top
                  Icon(Icons.menu_book_outlined,
                      size: 100, color: Colors.amber[400]),
                  SizedBox(height: 20),
                  Text(
                    'Library',
                    style: TextStyle(
                      color: Colors.amber[500],
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Personal Library',
                    style: TextStyle(
                      color: Colors.amber[400],
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 50),
                  CircularProgressIndicator(
                    color: Colors.amber[800],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// CircularProgressIndicator(),