
import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';

import '../../../../core/rest_services/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getUpcomingMoviesImpl();
  Future<Either<Failure, List<Movie>>> getPopularMoviesImpl();
  Future<Either<Failure, List<Movie>>> getTopRatedMoviesImpl();
  Future<Either<Failure, List<Movie>>> getMovieListImpl(int pageNumber);
}