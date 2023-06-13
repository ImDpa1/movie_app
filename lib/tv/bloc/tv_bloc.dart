import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../utils/apis.dart';
import '../model/tv_module.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvStateImp> {
  TvBloc() : super(TvInitial()) {
    on<TvEvent>((event, emit) {
    });
    on<LoadingEvent>((event, emit) => emit(state.copyWith(
      status: TvStatus.loading,
    )));
    on<FetchTvEvent>(_fetchTv);
  }
  void _fetchTv(event, emit) async{
    http.Response response = await http.get(Uri.parse(Apis.getTvShow));
    if(response.statusCode == 200){
      var jsonBody = jsonDecode(response.body);
      TvModule movieModule = TvModule.fromJson(jsonBody);
      emit(state.copyWith(status: TvStatus.success,
          tvModule: movieModule
      ));
    }else{
      emit(state.copyWith(status: TvStatus.failure));
    }
  }
}
