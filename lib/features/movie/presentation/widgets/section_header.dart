import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.fontSize = 30,
    this.fontWeight = FontWeight.w800,
    this.textAlign = TextAlign.left,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style: GoogleFonts.openSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
