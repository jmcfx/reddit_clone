import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/error_text.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/firebase_options.dart';
import 'package:reddit_app/router.dart';
import 'package:reddit_app/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Screen Util....
    return ScreenUtilInit(
      designSize: const Size(430.0, 932.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // Material App....
        return ref.watch(authStateChangeProvider).when(
              data: (data) => MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Reddit App',
                theme: Palette.darkModeAppTheme,
                routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                  if (data != null) {
                    return loggedInRoute;
                  }
                  return loggedOutRoute;
                }),
                routeInformationParser: const RoutemasterParser(),
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            );
      },
    );
  }
}
