part of 'movie_cubit.dart';

abstract class MovieState{
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {}

class MovieError extends MovieState {
  final Failure failure;

  const MovieError(this.failure);
}
