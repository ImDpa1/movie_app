part of 'tv_detail_bloc.dart';

enum TvDetailStatus{
  initial,
  loading,
  failure,
  success,
}
@immutable
abstract class TvDetailState extends Equatable{
  final TvDetailStatus status;
  final TvDetailModule tvDetailModule;
  TvDetailState({required this.status,required this.tvDetailModule});

  @override
  List<Object?> get props=>[
    status,
    tvDetailModule
  ];
}

class TvDetailStateImp extends TvDetailState {
  TvDetailStateImp({
    required super.status,
    required super.tvDetailModule
  });
  TvDetailStateImp copyWith({
    TvDetailStatus ? status,
    TvDetailModule? tvDetailModule,
  }) {
    return TvDetailStateImp(status: status ?? this.status,
        tvDetailModule: tvDetailModule ?? this.tvDetailModule
    );
  }}

class TvDetailInitial extends TvDetailStateImp {
  TvDetailInitial() :super(
    status: TvDetailStatus.initial,
    tvDetailModule: TvDetailModule(),
  );
}
