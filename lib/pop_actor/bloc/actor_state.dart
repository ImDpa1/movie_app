part of 'actor_bloc.dart';
enum ActorStatus {
  initial,
  loading,
  failure,
  success,
}

@immutable
abstract class ActorState extends Equatable {
  final ActorStatus status;
  final ActorModule actorModule;

  ActorState({
    required this.status,
    required this.actorModule,
  });

  @override
  List<Object?> get props => [status,actorModule];
}

class ActorStateImp extends ActorState {
  ActorStateImp({
    required ActorStatus status,
    required ActorModule actorModule,
  }) : super(status: status,
    actorModule: actorModule,
  );
  ActorStateImp copyWith({
    ActorStatus? status,
    ActorModule? actorModule,
  }) {
    return ActorStateImp(
      status: status ?? this.status,
      actorModule: actorModule ?? this.actorModule,
    );
  }
}

class ActorInitial extends ActorStateImp {
  ActorInitial()
      : super(
    status: ActorStatus.initial,
    actorModule: ActorModule(),
  );
}
