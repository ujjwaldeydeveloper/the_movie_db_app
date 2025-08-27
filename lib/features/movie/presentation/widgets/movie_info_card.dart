import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db_app/core/constants/app_colors.dart';

class MovieInfoCard extends StatelessWidget {
  const MovieInfoCard({
    super.key,
    required this.label,
    required this.value,
    this.showStar = false,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 10,
  });

  final String label;
  final String value;
  final bool showStar;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: Colours.borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showStar) ...[
            const SizedBox(width: 4),
            const Icon(
              Icons.star,
              color: Colours.starColor,
            ),
          ],
          const SizedBox(width: 4),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
