import 'package:flutter/material.dart';
import 'package:the_movie_db_app/core/constants/app_strings.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    super.key,
    required this.posterPath,
    this.borderRadius,
    this.fit = BoxFit.fill,
    this.filterQuality = FilterQuality.high,
  });

  final String posterPath;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      '${AppString.imagePath}$posterPath',
      filterQuality: filterQuality,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.movie,
            size: 50,
            color: Colors.grey,
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }
}
