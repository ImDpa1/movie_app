import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../utils/apis.dart';
import '../movie_model/movie_module.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieStateImp> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) {
    });
    on<LoadingEvent>((event, emit) => emit(state.copyWith(
      status: MovieStatus.loading,
    )));
    on<FetchMovieEvent>(_fetchMovie);
  }
  void _fetchMovie(event, emit) async{
    http.Response response = await http.get(Uri.parse(Apis.getMovie));
    if(response.statusCode == 200){
      var jsonBody = jsonDecode(response.body);
      MovieModule movieModule = MovieModule.fromJson(jsonBody);
      emit(state.copyWith(status: MovieStatus.success, movieModule: movieModule  ));
    }else{
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }
}
