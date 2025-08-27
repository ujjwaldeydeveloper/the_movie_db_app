

import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';

import '../../../../core/rest_services/failure.dart';

abstract class MovieDataSource {
  Future<Either<Failure, List<Movie>>> getUpcomingMoviesResponse();
  Future<Either<Failure, List<Movie>>> getPopularMoviesResponse();
  Future<Either<Failure, List<Movie>>> getTopRatedMoviesResponse();
  Future<Either<Failure, List<Movie>>> getMovieListResponse(int pageNumber);
}