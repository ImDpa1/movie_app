part of 'movie_bloc.dart';
enum MovieStatus{
  initial,
  loading,
  failure,
  success,
}
@immutable
abstract class MovieState extends Equatable{
  final MovieStatus status;
  final MovieModule movieModule;
  MovieState({
    required this.movieModule,
    required this.status,
});
  @override
  List<Object?> get props => [
    status,
    movieModule,
  ];
}
class MovieStateImp extends MovieState{
  MovieStateImp({
    required super.status,
  required super.movieModule});

  MovieStateImp copyWith({
  MovieStatus ? status,
    MovieModule ? movieModule,
}){
    return MovieStateImp(status: status ?? this.status,
      movieModule: movieModule ?? this.movieModule,);
  }
}
class MovieInitial extends MovieStateImp{
  MovieInitial():super(
    status: MovieStatus.initial,
    movieModule: MovieModule(),
  );
}
