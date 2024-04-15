import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/constants/constants.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/theme/palette.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(BuildContext context , WidgetRef ref) {
    ref.read(authControllerProvider.notifier).sigInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0).r,
      child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle( context, ref),
        icon: Image.asset(Constants.googlePath, width: 35.w),
        label: Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18.sp),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.greyColor,
          minimumSize: Size(double.infinity, 50.h),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20).r
          // )
        ),
      ),
    );
  }
}
