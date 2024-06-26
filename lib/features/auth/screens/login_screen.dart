import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/core/common/sign_in_button.dart';
import 'package:reddit_app/core/constants/constants.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).sigInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40.r,
        ),
        actions: [
          TextButton(
            onPressed: () => signInAsGuest(ref, context),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Loader()
          : Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Dive into anything',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Image.asset(
                    Constants.loginEmotePath,
                    height: 400.h,
                  ),
                ),
                const SignInButton()
              ],
            ),
    );
  }
}
