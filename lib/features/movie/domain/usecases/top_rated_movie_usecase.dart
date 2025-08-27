import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/core/rest_services/failure.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';
import 'package:the_movie_db_app/features/movie/domain/repositories/movie_repository.dart';

class TopRatedMovieUsecase {
  final MovieRepository movieRepository;

  TopRatedMovieUsecase({required this.movieRepository});


  Future<Either<Failure, List<Movie>>> execute() async {
    return await movieRepository.getTopRatedMoviesImpl();
  }
}
  
  
  
  