import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostCards extends StatelessWidget {
  const AddPostCards({
    super.key,
    required this.cardHeightWidth,
    required this.currentTheme,
    required this.iconSize,
    this.onTap,
    this.icons,
  });

  final double cardHeightWidth;
  final ThemeData currentTheme;
  final double iconSize;
  final void Function()? onTap;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
