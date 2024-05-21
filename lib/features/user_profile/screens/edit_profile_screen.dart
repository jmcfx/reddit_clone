import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/error_text.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/core/constants/constants.dart';
import 'package:reddit_app/core/utils.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/features/user_profile/controller/user_profile_controller.dart';
import 'package:reddit_app/theme/palette.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.uid});
  final String uid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? bannerFile, profileFile;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save() {
    ref.read(userProfileControllerProvider.notifier).editCommunity(
        profileFile: profileFile,
        bannerFile: bannerFile,
        context: context,
        name: nameController.text.trim());
    
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProfileControllerProvider);
    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
            backgroundColor: Palette.darkModeAppTheme.colorScheme.background,
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: save,
                  child: const Text('Save'),
                )
              ],
            ),
            body: isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.all(8.0).r,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: selectBannerImage,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10).r,
                                      dashPattern: const [10, 4],
                                      strokeCap: StrokeCap.round,
                                      color: Palette.darkModeAppTheme.textTheme
                                          .bodyMedium!.color!,
                                      child: Container(
                                        width: double.infinity,
                                        height: 150.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10).r,
                                        ),
                                        child: bannerFile != null
                                            ? Image.file(bannerFile!)
                                            : user.banner.isEmpty ||
                                                    user.banner ==
                                                        Constants.bannerDefault
                                                ? const Center(
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 40,
                                                    ),
                                                  )
                                                : Image.network(user.banner),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0).r,
                                      child: GestureDetector(
                                        onTap: selectProfileImage,
                                        child: profileFile != null
                                            ? CircleAvatar(
                                                backgroundImage:
                                                    FileImage(profileFile!),
                                                radius: 32.r,
                                              )
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  user.profilePic,
                                                ),
                                                radius: 32.r,
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Name',
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(18.r),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          error: ((error, stackTrace) => ErrorText(
                error: error.toString(),
              )),
          loading: () => const Loader(),
        );
  }
}
