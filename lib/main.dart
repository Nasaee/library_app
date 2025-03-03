import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:library_app/constants/router.dart';
import 'package:library_app/db/db.dart';
import 'package:library_app/providers/category_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensure Flutter is initialized
  await DatabaseHelper().ensureDefaultCategories(); // ✅ Ensure categories exist

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CategoryProvider()), // ✅ Provide globally
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: EasyLoading.init(),
    );
  }
}
