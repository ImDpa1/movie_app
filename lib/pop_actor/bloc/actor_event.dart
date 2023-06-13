part of 'actor_bloc.dart';

@immutable
abstract class ActorEvent {}
class LoadingEvent extends ActorEvent{}
class FetchActorEvent extends ActorEvent{}
