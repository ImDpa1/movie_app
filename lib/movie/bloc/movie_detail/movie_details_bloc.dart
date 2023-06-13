import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' ;
import 'package:equatable/equatable.dart';

import 'package:new_app/movie/bloc/movie_bloc.dart';
import 'package:new_app/movie/movie_model/movie_detail_module.dart';
import 'package:new_app/utils/apis.dart';
import 'package:new_app/utils/routes_generator.dart';
part 'movie_details_event.dart';
part 'movie_details_state.dart';



class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailStateImp> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) {
    });
    on<FetchMovieDetailEvent>(_onMovieDetailfetch);
  }


    void _onMovieDetailfetch(FetchMovieDetailEvent event,emit)async{
      try{
        var url = Apis.movie + event.movieId + Apis.urlLastPart;
        Response response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
          var jsonBody = jsonDecode(response.body);
          MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(jsonBody);
          emit(state.copyWith(status:MovieDetailStatus.success,module: movieDetailModel));
        }else{

        }
      }on SocketException catch (error){
        ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text("No internet!")));

      }on Error catch (e){
        print(e);
      }
    }
  }