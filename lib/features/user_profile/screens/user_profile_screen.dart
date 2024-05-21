import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/error_text.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key, required this.uid});
  final String uid;

  void navigateToUserEditUSer(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
          data: (user) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 250.h,
                      floating: true,
                      snap: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              user.banner,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding:
                                EdgeInsets.all(20.r).copyWith(bottom: 70.r),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePic),
                              radius: 45.r,
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.all(20.r),
                            child: OutlinedButton(
                              onPressed: () => navigateToUserEditUSer(context),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20).r,
                                ),
                                side: BorderSide(
                                    width: 0.4.w, color: Colors.white),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.h,
                                ),
                              ),
                              child: const Text("Edit Profile"),
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16).r,
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'u/${user.name}',
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.r),
                            child: Text('${user.karma} karma'),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(
                            thickness: 2.r,
                          )
                        ]),
                      ),
                    ),
                  ];
                },
                body: Container(),
              ),
          error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
          loading: () => const Loader()),
    );
  }
}
