import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ImageProvider backgroundImage;
  bool _isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    backgroundImage = const AssetImage('assets/images/bg.jpg');

    // Preload the image
    final ImageStream stream =
        backgroundImage.resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() {
          _isImageLoaded = true;
        });

        // Navigate after the image is loaded & 5-second delay
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ));
          }
        });
      }
    }));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Render nothing until the image is fully loaded
    if (!_isImageLoaded) {
      return Container(color: Colors.black);
    }

    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withAlpha((0.5 * 255).toInt()), BlendMode.darken),
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 200,
            right: 30,
            left: 30,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Icon(Icons.menu_book_outlined,
                      size: 100, color: Colors.amber[400]),
                  const SizedBox(height: 20),
                  Text(
                    'Library',
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
