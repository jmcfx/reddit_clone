import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/error_text.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/core/utils.dart';
import 'package:reddit_app/features/auth/controller/community_controller.dart';
import 'package:reddit_app/features/post/controller/post_controller.dart';
import 'package:reddit_app/models/community_model.dart';
import 'package:reddit_app/theme/palette.dart';

class AddPostTypeScreen extends ConsumerStatefulWidget {
  final String type;
  const AddPostTypeScreen({required this.type, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPostTypeScreenState();
}

class _AddPostTypeScreenState extends ConsumerState<AddPostTypeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  File? bannerFile;
  List<Community> communities = [];
  Community? selectedCommunity;
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }
  void sharePost() {
    if (widget.type == 'image' &&
        bannerFile != null &&
        titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareImagePost(
          context: context,
          title: titleController.text.trim(),
          selectedCommunity: selectedCommunity ?? communities[0],
          file: bannerFile);
    } else if (widget.type == 'text' && titleController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareTextPost(
          context: context,
          title: titleController.text.trim(),
          selectedCommunity: selectedCommunity ?? communities[0],
          description: descriptionController.text.trim());
    } else if (widget.type == 'link' &&
        titleController.text.isNotEmpty &&
        linkController.text.isNotEmpty) {
      ref.read(postControllerProvider.notifier).shareLinkPost(
          context: context,
          title: titleController.text.trim(),
          selectedCommunity: selectedCommunity ?? communities[0],
          link: linkController.text.trim());
    } else {
      showSnackBar(context, 'Please enter all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTypeImage = widget.type == "image";
    final isTypeText = widget.type == "text";
    final isTypeLink = widget.type == "link";
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.type}'),
        actions: [
          TextButton(
            onPressed: sharePost,
            child: const Text('Share'),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Enter Title here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18.r),
              ),
              maxLength: 30,
            ),
            SizedBox(height: 10.r),
            if (isTypeImage)
              GestureDetector(
                onTap: selectBannerImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10).r,
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: currentTheme.textTheme.bodyMedium!.color!,
                  child: Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: bannerFile != null
                        ? Image.file(bannerFile!)
                        : const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              ),
            if (isTypeText)
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter Description here',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18.r),
                ),
                maxLines: 5,
              ),
            if (isTypeLink)
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter Link here',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18.r),
                ),
              ),
            SizedBox(height: 20.h),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Select Community'),
            ),
            ref.watch(userCommunitiesProvider).when(
                  data: (data) {
                    communities = data;
                    if (data.isEmpty) {
                      return const SizedBox();
                    }
                    return DropdownButton(
                      value: selectedCommunity ?? data[0],
                      items: data
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCommunity = val;
                        });
                      },
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => const Loader(),
                )
          ],
        ),
      ),
    );
  }
}
