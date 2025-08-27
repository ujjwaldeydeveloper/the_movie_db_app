

import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/core/rest_services/failure.dart';
import 'package:the_movie_db_app/features/movie/data/datasources/movie_data_source.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';
import 'package:the_movie_db_app/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource movieDataSource;

  MovieRepositoryImpl({required this.movieDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMoviesImpl() async {
    return await movieDataSource.getUpcomingMoviesResponse();
  }
  
  
  @override
  Future<Either<Failure, List<Movie>>> getPopularMoviesImpl() async {
    return await movieDataSource.getPopularMoviesResponse();

    // return result
  }
  
  
  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMoviesImpl() async {
    return await movieDataSource.getTopRatedMoviesResponse();
  }
  
  
  @override
  Future<Either<Failure, List<Movie>>> getMovieListImpl(int pageNumber) async {
    return await movieDataSource.getMovieListResponse(pageNumber);
  }
  
  
  
}