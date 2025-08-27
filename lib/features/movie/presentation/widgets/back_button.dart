import 'package:flutter/material.dart';
import 'package:the_movie_db_app/core/constants/app_colors.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
    this.size = 70.0,
    this.margin = const EdgeInsets.only(top: 16, left: 16),
    this.backgroundColor = Colours.ratingColor,
    this.iconColor,
    this.borderRadius = 8.0,
    this.onPressed,
  });

  final double size;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final Color? iconColor;
  final double borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: iconColor ?? Colors.white,
        ),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}