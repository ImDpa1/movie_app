part of 'actor_detail_bloc.dart';

enum ActorDetailStatus{
  initial,
  loading,
  success,
  failure,
}
@immutable
abstract class ActorDetailState extends Equatable{
  final ActorDetailStatus status;
  final ActorDetailModel actorDetail;
  ActorDetailState({required this.status,required this.actorDetail});

  @override
  List<Object?> get props =>[status,actorDetail
  ];
}
class ActorDetailStateImp extends ActorDetailState{
  ActorDetailStateImp({required super.status,required super.actorDetail});

  ActorDetailStateImp copyWith({ActorDetailStatus? status,
    ActorDetailModel? actorDetail,
  }){
    return ActorDetailStateImp(status: status?? this.status,actorDetail:actorDetail?? this.actorDetail);
  }
}
class ActorDetailInitial extends ActorDetailStateImp{
  ActorDetailInitial():super(status: ActorDetailStatus.initial,actorDetail: ActorDetailModel());
}
