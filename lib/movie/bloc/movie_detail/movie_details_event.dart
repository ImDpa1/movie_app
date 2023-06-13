part of 'movie_details_bloc.dart';


@immutable
abstract class MovieDetailEvent {}
class FetchMovieDetailEvent extends MovieDetailEvent{
  final String movieId ;
  FetchMovieDetailEvent({required this.movieId});
}
