part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}
class LoadingEvent extends MovieEvent{}
class FetchMovieEvent extends MovieEvent{}
