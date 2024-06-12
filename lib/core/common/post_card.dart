import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/constants/constants.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/features/post/controller/post_controller.dart';
import 'package:reddit_app/models/post_model.dart';
import 'package:reddit_app/theme/palette.dart';

class PostCard extends ConsumerWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  void deletePost(WidgetRef ref,  BuildContext context ) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == "image";
    final isTypeText = post.type == "text";
    final isTypeLink = post.type == "link";
    final currentTheme = ref.watch(themeNotifierProvider);
    final user = ref.watch(userProvider)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: currentTheme.drawerTheme.backgroundColor,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.r),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.r,
                        horizontal: 16.r,
                      ).copyWith(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(post.communityProfilePic),
                                    radius: 16.r,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'r/${post.communityName}',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'u/${post.username}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (post.uid == user.uid)
                                IconButton(
                                  onPressed: () => deletePost(ref, context),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Palette.redColor,
                                  ),
                                )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0).r,
                            child: Text(
                              post.title,
                              style: TextStyle(
                                  fontSize: 19.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (isTypeImage)
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.35.h,
                              width: double.infinity,
                              child: Image.network(
                                post.link!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (isTypeLink)
                            Padding(
                                 padding:  EdgeInsets.symmetric(horizontal: 18.r) ,  
                              child: AnyLinkPreview(
                                link: post.link!,
                                displayDirection:
                                    UIDirection.uiDirectionHorizontal,
                              ),
                            ),
                          if (isTypeText)
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.symmetric(horizontal: 15.0.r),
                              child: Text(
                                post.description!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Constants.up,
                                  size: 30,
                                  color: post.upVotes.contains(user.uid)
                                      ? Palette.redColor
                                      : null,
                                ),
                              ),
                              Text(
                                '${post.upVotes.length - post.downVotes.length == 0 ? 'Vote' : post.upVotes.length - post.downVotes.length}',
                                style: TextStyle(fontSize: 17.sp),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Constants.up,
                                  size: 30,
                                  color: post.downVotes.contains(user.uid)
                                      ? Palette.blueColor
                                      : null,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.comment),
                                  ),
                                  Text(
                                    '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                    style: TextStyle(fontSize: 17.sp),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
