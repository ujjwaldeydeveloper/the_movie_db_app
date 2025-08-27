import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/core/rest_services/failure.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';

import '../../domain/usecases/movie_list_usecase.dart';
import '../../domain/usecases/popular_movie_usecase.dart';
import '../../domain/usecases/top_rated_movie_usecase.dart';
import '../../domain/usecases/upcoming_movie_usecase.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({
    required this.getUpcomingMoviesUsecase, 
    required this.getPopularMoviesUsecase, 
    required this.getTopRatedMoviesUsecase, 
    required this.getMovieListUsecase
}) : super(MovieInitial());

  final UpcomingMovieUsecase getUpcomingMoviesUsecase;
  final PopularMovieUsecase getPopularMoviesUsecase;
  final TopRatedMovieUsecase getTopRatedMoviesUsecase;
  final MovieListUsecase getMovieListUsecase;

 List<Movie> upcomingMovies = [];
 List<Movie> topRatedMovies = [];
 List<Movie> trendingMovies = [];
 List<Movie> popularMovies = [];

  Future<void> getUpcomingMovies() async {
    emit(MovieLoading());  
    // final response = await ApiService().dio.get(ApiService().upcomingMoviePath);

    // debugPrint('API Response: ${response.data}');
    try {
      final Either<Failure,List<Movie>> result = await getUpcomingMoviesUsecase.execute();
      result.fold(
        (l) => emit(MovieError(l)), 
        (r) {
          upcomingMovies.addAll(r as List<Movie>);
          emit(MovieLoaded());
        }
      );
    }
    catch(e) {
      emit(MovieError(Failure(message: e.toString())));
    }
  }

  Future<void> getPopularMovies() async {
    emit(MovieLoading());
    try {
      final dynamic result = await getPopularMoviesUsecase.execute();
    result.fold((l) => emit(MovieError(l)), (r) {
      popularMovies.addAll(r as List<Movie>);
      emit(MovieLoaded());
    });

    } catch (e) {
      emit(MovieError(Failure(message: e.toString())));
    }
    
  }

  Future<void> getTopRatedMovies() async {
    emit(MovieLoading());
    try {
      final result = await getTopRatedMoviesUsecase.execute();
      result.fold((l) => emit(MovieError(l)), (r){
        topRatedMovies.addAll(r as List<Movie>);
        emit(MovieLoaded());
      });
    } catch (e) {
      emit(MovieError(Failure(message: e.toString())));
    }
  }
  
  Future<void> getMovieList(int pageNumber) async {
    emit(MovieLoading());
    final result = await getMovieListUsecase.execute(pageNumber);
    result.fold((l) => emit(MovieError(l)), (r) {
      emit(MovieLoaded());
    });
  }
  
  
  
}
