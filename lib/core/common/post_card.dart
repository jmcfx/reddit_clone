import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/error_text.dart';
import 'package:reddit_app/core/common/loader.dart';
import 'package:reddit_app/core/constants/constants.dart';
import 'package:reddit_app/features/auth/controller/auth_controller.dart';
import 'package:reddit_app/features/auth/controller/community_controller.dart';
import 'package:reddit_app/features/post/controller/post_controller.dart';
import 'package:reddit_app/models/post_model.dart';
import 'package:reddit_app/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class PostCard extends ConsumerWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void upVotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).upVote(post);
  }

  void downVotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).downVote(post);
  }

  void awardPost(WidgetRef ref, String award, BuildContext context) async {
    ref.read(postControllerProvider.notifier).awardPost(
          post: post,
          award: award,
          context: context,
        );
  }

  void navigateToUser(BuildContext context) {
    Routemaster.of(context).push('/u/${post.uid}');
  }

  void navigateToCommunity(BuildContext context) {
    Routemaster.of(context).push('/r/${post.communityName}');
  }

  void navigateToComments(BuildContext context) {
    Routemaster.of(context).push('/post/${post.id}/comments');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == "image";
    final isTypeText = post.type == "text";
    final isTypeLink = post.type == "link";
    final currentTheme = ref.watch(themeNotifierProvider);
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
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
                                  GestureDetector(
                                    onTap: () => navigateToCommunity(context),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          post.communityProfilePic),
                                      radius: 16.r,
                                    ),
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
                                        GestureDetector(
                                          onTap: () => navigateToUser(context),
                                          child: Text(
                                            'u/${post.username}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
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
                          if (post.awards.isNotEmpty) ...[
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 25.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: post.awards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final award = post.awards[index];
                                  return Image.asset(
                                    Constants.awards[award]!,
                                    height: 23.h,
                                  );
                                },
                              ),
                            )
                          ],
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
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: post.link!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          if (isTypeLink)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.r),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed:isGuest ? (){} : () => upVotePost(ref),
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
                                onPressed: isGuest ? (){} : () => downVotePost(ref),
                                icon: Icon(
                                  Constants.down,
                                  size: 30,
                                  color: post.downVotes.contains(user.uid)
                                      ? Palette.blueColor
                                      : null,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        navigateToComments(context),
                                    icon: const Icon(Icons.comment),
                                  ),
                                  Text(
                                    '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                    style: TextStyle(fontSize: 17.sp),
                                  ),
                                ],
                              ),
                              ref
                                  .watch(getCommunityByNameProvider(
                                      post.communityName))
                                  .when(
                                    data: (data) {
                                      if (data.mods.contains(user.uid)) {
                                        return IconButton(
                                          onPressed: () =>
                                              deletePost(ref, context),
                                          icon: const Icon(
                                              Icons.admin_panel_settings),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                    error: (error, stackTrace) =>
                                        ErrorText(error: error.toString()),
                                    loading: () => const Loader(),
                                  ),
                              IconButton(
                                onPressed: isGuest ? (){} : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.r),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                          ),
                                          itemCount: user.awards.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final award = user.awards[index];
                                            return GestureDetector(
                                              onTap: () => awardPost(
                                                  ref, award, context),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0).r,
                                                child: Image.asset(
                                                  Constants.awards[award]!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.card_giftcard_outlined),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
