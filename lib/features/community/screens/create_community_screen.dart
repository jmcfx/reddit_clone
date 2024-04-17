import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/features/auth/controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a community'),
      ),
      body: isLoading ?  const Loader() :   Padding(
        padding: const EdgeInsets.all(10.0).r,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Community name'),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: communityNameController,
              decoration: InputDecoration(
                  hintText: 'r/Community_name',
                  filled: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(18).r),
              maxLength: 21,
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              onPressed: createCommunity,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20).r)),
              child: Text(
                'Create community',
                style: TextStyle(fontSize: 17.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
