import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/movie/bloc/movie_detail/movie_details_bloc.dart';
import 'package:new_app/pop_actor/bloc/actor_bloc.dart';
import 'package:new_app/pop_actor/bloc/actor_detail/actor_detail_bloc.dart';
import 'package:new_app/tv/bloc/tv_bloc.dart';
import 'package:new_app/tv/bloc/tv_cast/tv_cast_bloc.dart';
import 'package:new_app/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:new_app/utils/routes_generator.dart';

// import 'login_form/login_screen.dart';
import 'main_screen.dart';
import 'movie/bloc/movie_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
        BlocProvider(
          create: (context) => TvBloc(),
        ),
        BlocProvider(
          create: (context) => ActorBloc(),
        ),
        BlocProvider(create: (_)=>MovieDetailBloc()
        ),
        BlocProvider(create: (_)=>TvDetailBloc()
        ),
        BlocProvider(create: (_)=>TvCastBloc()),
        BlocProvider(create: (_)=>ActorDetailBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.onGenerator,
        navigatorKey: RouteGenerator.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
        // home: LoginScreen(),
      ),
    );
  }
}
