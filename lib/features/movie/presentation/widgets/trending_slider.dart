import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';
import 'package:the_movie_db_app/features/movie/presentation/pages/details_screen.dart';
import 'package:the_movie_db_app/features/movie/presentation/widgets/movie_poster.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.movies,
    this.height = 300,
    this.itemWidth = 200,
    this.viewportFraction = 0.55,
    this.enlargeCenterPage = true,
    this.autoPlay = true,
    this.onMovieTap,
  });

  final List<Movie> movies;
  final double height;
  final double itemWidth;
  final double viewportFraction;
  final bool enlargeCenterPage;
  final bool autoPlay;
  final Function(Movie)? onMovieTap;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text('No trending movies available'),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: movies.length,
        options: CarouselOptions(
          height: height,
          autoPlay: autoPlay,
          viewportFraction: viewportFraction,
          enlargeCenterPage: enlargeCenterPage,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final movie = movies[itemIndex];
          return GestureDetector(
            onTap: () => _handleMovieTap(context, movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: height,
                width: itemWidth,
                child: MoviePoster(
                  posterPath: movie.posterPath,
                  fit: BoxFit.cover,
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