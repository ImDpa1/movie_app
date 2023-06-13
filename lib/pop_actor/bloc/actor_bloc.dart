import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../utils/apis.dart';
import '../actor_model/actor_module.dart';
part 'actor_event.dart';
part 'actor_state.dart';
class ActorBloc extends Bloc<ActorEvent, ActorStateImp> {

  ActorBloc() : super(ActorInitial()) {
    on<ActorEvent>((event, emit) {
    });
    on<LoadingEvent>((event, emit) => emit(state.copyWith(
    status: ActorStatus.loading,
    )));
    on<FetchActorEvent>(_fetchActor);
    }
    void _fetchActor(event, emit) async{
    http.Response response = await http.get(Uri.parse(Apis.getCelebs));
    if(response.statusCode == 200){
    var jsonBody = jsonDecode(response.body);
    ActorModule actorModule = ActorModule.fromJson(jsonBody);
    emit(state.copyWith(status: ActorStatus.success,
      actorModule:  actorModule
    ));
    }else{
    emit(state.copyWith(status: ActorStatus.failure));
    }
    }
  }
