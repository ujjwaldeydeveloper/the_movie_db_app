import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/movie/movie.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => MovieCubit(
          getUpcomingMoviesUsecase: UpcomingMovieUsecase(movieRepository: MovieRepositoryImpl(movieDataSource: MovieDataSourceImpl())),
          getPopularMoviesUsecase: PopularMovieUsecase(movieRepository: MovieRepositoryImpl(movieDataSource: MovieDataSourceImpl())),
          getTopRatedMoviesUsecase: TopRatedMovieUsecase(movieRepository: MovieRepositoryImpl(movieDataSource: MovieDataSourceImpl())),
          getMovieListUsecase: MovieListUsecase(movieRepository: MovieRepositoryImpl(movieDataSource: MovieDataSourceImpl())),
        ),
        child: const MoviePage(),
      )
    );
  }
}