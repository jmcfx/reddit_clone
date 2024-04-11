import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/features/auth/screens/login_screen.dart';
import 'package:reddit_app/firebase_options.dart';
import 'package:reddit_app/theme/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Screen Util....
    return ScreenUtilInit(
        designSize: const Size(430.0, 932.0),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          // Material App....
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Reddit App',
            theme: Palette.darkModeAppTheme,
            home: const LoginScreen(),
          );
        });
  }
}
