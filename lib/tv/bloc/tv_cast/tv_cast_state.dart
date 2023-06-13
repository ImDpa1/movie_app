part of 'tv_cast_bloc.dart';

enum TvCastStatus {
  initial,
  loading,
  failure,
  success,
  showFetchsuccess,
  showFetchfailure,
}

@immutable
abstract class TvCastState extends Equatable {
  final TvCastStatus status;
  final List<Cast> tvCastList;
  final List<ShowsCast> combinedCreditList;

  TvCastState({required this.status, required this.tvCastList,
  required this.combinedCreditList});

  @override
  List<Object?> get props => [
        status,
        tvCastList,
    combinedCreditList
      ];
}

class TvCastStateImp extends TvCastState {
  TvCastStateImp({required super.status, required super.tvCastList,
  required super.combinedCreditList
  });

  TvCastStateImp copyWith({
    TvCastStatus? status,
    List<Cast>? tvCastList,
    List<ShowsCast>? combinedCreditList,
  }) {
    return TvCastStateImp(
        status: status ?? this.status,
        tvCastList: tvCastList ?? this.tvCastList,
    combinedCreditList: combinedCreditList?? this.combinedCreditList
    );
  }
}

class TvCastInitial extends TvCastStateImp {
  TvCastInitial()
      : super(
          status: TvCastStatus.initial,
    tvCastList: [],
    combinedCreditList: [],
        );

}
