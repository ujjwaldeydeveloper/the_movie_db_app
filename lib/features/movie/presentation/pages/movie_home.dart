import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movie_db_app/features/movie/movie.dart';
import 'package:http/http.dart' as http;
import 'package:the_movie_db_app/features/movie/presentation/widgets/movies_slider.dart';
import 'package:the_movie_db_app/features/movie/presentation/widgets/trending_slider.dart';
import 'package:the_movie_db_app/features/movie/presentation/widgets/trending_slider_shimmer.dart';
import 'package:the_movie_db_app/features/movie/presentation/widgets/movies_slider_shimmer.dart';

import '../../domain/entities/movie.dart';
import 'package:the_movie_db_app/core/constants/app_strings.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    // Get the cubit and fetch upcoming movies
    context.read<MovieCubit>().getUpcomingMovies();
    context.read<MovieCubit>().getTopRatedMovies();
    context.read<MovieCubit>().getPopularMovies();
    // context.read<MovieCubit>().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.movieApp),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
        final cubit = context.read<MovieCubit>();
        final upcomingMovies = cubit.upcomingMovies;
        final topRatedMovies = cubit.topRatedMovies;
        final popularMovies = cubit.popularMovies;
        final trendingMovies = cubit.popularMovies;

        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MovieLoaded) {
          // Access the cubit to get the movies data
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.trendingMovies,
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                  const SizedBox(height: 32),
                  trendingMovies.isNotEmpty
                      ? TrendingSlider(movies: trendingMovies)
                      : const TrendingSliderShimmer(),
                  const SizedBox(height: 32),
                  Text(
                    AppString.popularMovies,
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                  const SizedBox(height: 32),
                  popularMovies.isNotEmpty
                      ? MoviesSlider(movies: popularMovies)
                      : const MoviesSliderShimmer(),
                  const SizedBox(height: 32),
                  Text(
                    AppString.topRatedMovies,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 32),
                  topRatedMovies.isNotEmpty
                      ? MoviesSlider(movies: topRatedMovies)
                      : const MoviesSliderShimmer(),
                  const SizedBox(height: 32),
                  Text(
                    AppString.upcomingMovies,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 32),
                  upcomingMovies.isNotEmpty
                      ? MoviesSlider(movies: upcomingMovies)
                      : const MoviesSliderShimmer(),
                ],
              ),
            ),
          );
        }
        if (state is MovieError) {
          return Center(
              child: Text('${AppString.errorPrefix}${state.failure.message}'));
        }
        return const SizedBox();
      }),
    );
  }
}
