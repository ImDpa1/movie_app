part of 'tv_cast_bloc.dart';

@immutable
abstract class TvCastEvent {}
class LoadingEvent extends TvCastEvent{}
class FetchCastEvent extends TvCastEvent{
  final String id;
  FetchCastEvent({required this.id});
}

class FetchActorShowsEvent extends TvCastEvent{
  final String id;
  FetchActorShowsEvent({required this.id});
}
