import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/core/rest_services/api_service.dart';
import 'package:the_movie_db_app/core/rest_services/failure.dart';
import 'package:the_movie_db_app/core/rest_services/network_interceptor.dart';
import 'package:the_movie_db_app/features/movie/data/datasources/movie_data_source.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final ApiService _apiService = ApiService();

  @override
  Future<Either<Failure, List<Movie>>>
      getUpcomingMoviesResponse() async {
    try {
      // Check internet connectivity first
      if (!await NetworkInterceptor.hasInternetConnection()) {
        return Left(Failure(message: 'No internet connection available'));
      }

      final response = await NetworkInterceptor.getWithRetry(
        _apiService.upcomingMovieUrl,
        maxRetries: 3,
        timeout: const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != false) {
          final results = data['results'] as List?;
          if (results != null) {
            return Right<Failure, List<Movie>>(
              results.map((movie) => Movie.fromJson(movie)).toList()
            );
          }
        }
      }
      
      return Left(Failure(message: 'Failed to fetch upcoming movies'));
    } on SocketException catch (e) {
      return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
    } catch (e) {
      if (NetworkInterceptor.isNetworkError(e)) {
        return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
      }
      return Left<Failure, List<Movie>>(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>>
      getMovieListResponse(int pageNumber) async {
    try {
      // Check internet connectivity first
      if (!await NetworkInterceptor.hasInternetConnection()) {
        return Left(Failure(message: 'No internet connection available'));
      }

      final response = await NetworkInterceptor.getWithRetry(
        _apiService.moviePagePath(pageNumber),
        maxRetries: 3,
        timeout: const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != false) {
          final results = data['results'] as List?;
          if (results != null) {
            return Right<Failure, List<Movie>>(
              results.map((movie) => Movie.fromJson(movie)).toList()
            );
          }
        }
      }
      
      return Left(Failure(message: 'Failed to fetch movie list'));
    } on SocketException catch (e) {
      return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
    } catch (e) {
      if (NetworkInterceptor.isNetworkError(e)) {
        return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
      }
      return Left(Failure.fromException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>>
      getPopularMoviesResponse() async {
    try {
      // Check internet connectivity first
      if (!await NetworkInterceptor.hasInternetConnection()) {
        return Left(Failure(message: 'No internet connection available'));
      }

      final response = await NetworkInterceptor.getWithRetry(
        _apiService.popularMovieUrl,
        maxRetries: 3,
        timeout: const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != false) {
          final results = data['results'] as List?;
          if (results != null) {
            return Right<Failure, List<Movie>>(
              results.map((movie) => Movie.fromJson(movie)).toList()
            );
          }
        }
      }
      
      return Left(Failure(message: 'Failed to fetch popular movies'));
    } on SocketException catch (e) {
      return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
    } catch (e) {
      if (NetworkInterceptor.isNetworkError(e)) {
        return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
      }
      return Left<Failure, List<Movie>>(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>>
      getTopRatedMoviesResponse() async {
    try {
      // Check internet connectivity first
      if (!await NetworkInterceptor.hasInternetConnection()) {
        return Left(Failure(message: 'No internet connection available'));
      }

      final response = await NetworkInterceptor.getWithRetry(
        _apiService.topRatedMovieUrl,
        maxRetries: 3,
        timeout: const Duration(seconds: 30),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != false) {
          final results = data['results'] as List?;
          if (results != null) {
            return Right<Failure, List<Movie>>(
            results.map((movie) => Movie.fromJson(movie)).toList()
          );
        }
      }
      }
      
      return Left(Failure(message: 'Failed to fetch top rated movies'));
    } on SocketException catch (e) {
      return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
    } catch (e) {
      if (NetworkInterceptor.isNetworkError(e)) {
        return Left(Failure(message: NetworkInterceptor.getNetworkErrorMessage(e)));
      }
      return Left<Failure, List<Movie>>(Failure(message: e.toString()));
    }
  }
}
