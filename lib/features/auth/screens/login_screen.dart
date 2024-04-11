import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/sign_in_button.dart';
import 'package:reddit_app/core/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40.r,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Column(
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
            child: Image.asset(Constants.loginEmotePath, height: 400.h,),
          ),
          
      const SignInButton()
        ],
      ),
    );
  }
}
