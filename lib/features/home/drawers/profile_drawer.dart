import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/theme/palette.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 70.r,
            ),
            SizedBox(height: 10.h),
            Text(
              'u/${user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),
            const Divider(),
            ListTile(
              title: const Text('My Profile '),
              leading: const Icon(Icons.person),
              onTap: () {},
            ),
            ListTile(
              title: const Text(' Log Out '),
              leading: Icon(
                Icons.logout,
                color: Palette.redColor,
              ),
              onTap: () =>logOut(ref),
            ),
            Switch.adaptive(value: true, onChanged: (val) {})
          ],
        ),
      ),
    );
  }
}
