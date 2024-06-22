import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/core/common/add_post_cards.dart';
import 'package:reddit_app/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  void navigateToType(BuildContext context, String type) {
    Routemaster.of(context).push('/add-post/$type');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cardHeightWidth = 120.r;
    double iconSize = 60.r;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //image....
        AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.image_outlined,
          onTap: () => navigateToType(context,'image' ),
        ),
        //text....
        AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.font_download_outlined,
           onTap: () => navigateToType(context, 'text'),
        ),
        //link....
        AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.link_outlined,
          onTap: () => navigateToType(context, 'link'),
        ),
      ],
    );
  }
}
