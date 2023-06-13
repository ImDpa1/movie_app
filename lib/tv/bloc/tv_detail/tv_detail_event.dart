part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailEvent {}
class FetchTvDetailEvent extends TvDetailEvent{
  final String id;
  FetchTvDetailEvent({required this.id});
}
