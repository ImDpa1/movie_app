import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../utils/apis.dart';
import '../../../utils/routes_generator.dart';
import '../../actor_model/actor_detail_model.dart';

part 'actor_detail_event.dart';

part 'actor_detail_state.dart';

class ActorDetailBloc extends Bloc<ActorDetailEvent, ActorDetailStateImp> {
  ActorDetailBloc() : super(ActorDetailInitial()) {
    on<ActorDetailEvent>((event, emit) {});
    on<FetchActorDetail>(_onActorDetailfetch);
  }

  void _onActorDetailfetch(FetchActorDetail event, emit) async {
    try {
      var url = Apis.celebs + event.id + Apis.urlLastPart;
      Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        ActorDetailModel detail = ActorDetailModel.fromJson(jsonBody);
        // TvDetailModule detail = TvDetailModule.fromJson(jsonBody);
        emit(state.copyWith(
          status: ActorDetailStatus.success,actorDetail: detail
          // tvDetailModule: detail
        ));
      } else {
        emit(state.copyWith(status: ActorDetailStatus.failure));
      }
    } on SocketException catch (error) {
      ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!)
          .showSnackBar(SnackBar(content: Text("No internet!")));
    } on Error catch (e) {
      print(e);
    }
  }
}
