part of 'tv_bloc.dart';

// @immutable
// abstract class TvState {}
//
// class TvInitial extends TvState {}
enum TvStatus{
  initial,
  loading,
  failure,
  success,
}
@immutable
abstract class TvState extends Equatable{
  final TvStatus status;
  final TvModule tvModule;
  TvState({
    required this.tvModule,
    required this.status,
  });
  @override
  List<Object?> get props => [
    status,
    TvModule,
  ];
}
class TvStateImp extends TvState{
  TvStateImp({
    required super.status,
    required super.tvModule});

  TvStateImp copyWith({
    TvStatus ? status,
    TvModule ? tvModule,
  }){
    return TvStateImp(status: status ?? this.status,
      tvModule: tvModule ?? this.tvModule,
    );
  }
}
class TvInitial extends TvStateImp{
  TvInitial():super(
    status: TvStatus.initial,
    tvModule: TvModule(),
  );
}

