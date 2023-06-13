import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../pop_actor/actor_model/shows_model.dart';
import '../../../utils/apis.dart';
import '../../../utils/routes_generator.dart';
import '../../model/tv_cast_model.dart';
import '../../model/tv_detail_model.dart';
import '../tv_detail/tv_detail_bloc.dart';

part 'tv_cast_event.dart';

part 'tv_cast_state.dart';

class TvCastBloc extends Bloc<TvCastEvent, TvCastStateImp> {
  TvCastBloc() : super(TvCastInitial()) {
    on<TvCastEvent>((event, emit) {});
    on<LoadingEvent>(
        (event, emit) => emit(state.copyWith(status: TvCastStatus.loading)));
    on<FetchCastEvent>((_onTvCastFetch));
    on<FetchActorShowsEvent>(_fetchCombineCredits);
  }

  void _onTvCastFetch(FetchCastEvent event, emit) async {
    try {
      var url = Apis.tv + event.id + Apis.creditLastUrl;
      Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        TvCastModel tvCast = TvCastModel.fromJson(jsonBody);
        emit(state.copyWith(
            status: TvCastStatus.success, tvCastList: tvCast.cast));
      } else {
        emit(state.copyWith(status: TvCastStatus.failure));
      }
    } on SocketException catch (error) {
      ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("No internet!")));
    } on Error catch (e) {
      print(e);
    }
  }

  void _fetchCombineCredits(FetchActorShowsEvent event, emit) async {
    var uris = Apis.celebs + event.id + "/combined_credits" + Apis.urlLastPart;

    try {
      Response response = await http.get(Uri.parse(uris));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        ShowsModel data = ShowsModel.fromJson(jsonBody);
        emit(state.copyWith(
          status: TvCastStatus.showFetchsuccess,combinedCreditList: data.cast
        ));
      } else {
        emit(state.copyWith(status: TvCastStatus.showFetchfailure));
      }
    } on SocketException catch (error) {
      ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("No internet!")));
      emit(state.copyWith(status: TvCastStatus.showFetchfailure));
    } on Error catch (e) {
      print(e);
      emit(state.copyWith(status: TvCastStatus.showFetchfailure));
    }
  }
}
