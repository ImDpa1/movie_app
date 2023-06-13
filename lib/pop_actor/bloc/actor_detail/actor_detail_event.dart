part of 'actor_detail_bloc.dart';

@immutable
abstract class ActorDetailEvent {}
class FetchActorDetail extends ActorDetailEvent{
  final String id;
  FetchActorDetail({required this.id});
}
