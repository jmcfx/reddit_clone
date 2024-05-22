import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reddit_app/theme/palette.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cardHeightWidth = 120.r;
    double iconSize = 60.r;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.image_outlined,
          onTap: () {},
        ),
         AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.font_download_outlined,
          onTap: (){},
        ),
        AddPostCards(
          cardHeightWidth: cardHeightWidth,
          currentTheme: currentTheme,
          iconSize: iconSize,
          icons: Icons.link_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}

class AddPostCards extends StatelessWidget {
  const AddPostCards({
    super.key,
    required this.cardHeightWidth,
    required this.currentTheme,
    required this.iconSize, this.onTap, this.icons,
  });

  final double cardHeightWidth;
  final ThemeData currentTheme;
  final double iconSize;
  final void Function()? onTap;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: cardHeightWidth,
        width: cardHeightWidth,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          color: currentTheme.colorScheme.background,
          elevation: 16.r,
          child: Center(
            child: Icon(
              icons,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
