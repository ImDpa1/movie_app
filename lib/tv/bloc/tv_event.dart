part of 'tv_bloc.dart';

@immutable
abstract class TvEvent {}
class LoadingEvent extends TvEvent{}
class FetchTvEvent extends TvEvent{}
