import 'package:dartz/dartz.dart';
import 'package:the_movie_db_app/features/movie/domain/entities/movie.dart';
import 'package:the_movie_db_app/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/rest_services/failure.dart';

class MovieListUsecase {
  final MovieRepository movieRepository;

  MovieListUsecase({required this.movieRepository});
  
  
  Future<Either<Failure, List<Movie>>> execute(int pageNumber) async {
    return await movieRepository.getMovieListImpl(pageNumber);
  }
  
  
  
}
  
  
  
  
  
  
  
  