import 'package:flutter/material.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';
import 'package:the_movie_db_app/features/movie/presentation/pages/details_screen.dart';
import 'package:the_movie_db_app/features/movie/presentation/widgets/movie_poster.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key,
    required this.movies,
    this.height = 200,
    this.itemWidth = 150,
    this.itemSpacing = 8.0,
    this.borderRadius = 8.0,
    this.onMovieTap,
  });

  final List<Movie> movies;
  final double height;
  final double itemWidth;
  final double itemSpacing;
  final double borderRadius;
  final Function(Movie)? onMovieTap;

  @override
  Widget build(BuildContext context) {
    //TODO: improve
    if (movies.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text('No movies available'),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.all(itemSpacing),
            child: GestureDetector(
              onTap: () => _handleMovieTap(context, movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: SizedBox(
                  height: height,
                  width: itemWidth,
                  child: MoviePoster(
                    posterPath: movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleMovieTap(BuildContext context, Movie movie) {
    if (onMovieTap != null) {
      onMovieTap!(movie);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(movie: movie),
        ),
      );
    }
  }
}