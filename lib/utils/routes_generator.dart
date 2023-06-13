import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/movie/screens/movie_detail_screen.dart';
import 'package:new_app/pop_actor/screen/actor_detail_screen.dart';
import 'package:new_app/tv/model/tv_module.dart';
import 'package:new_app/utils/routes.dart';

import '../movie/movie_model/movie_module.dart';
import '../tv/bloc/screens/tv_detail_screen.dart';
import '../tv/model/tv_cast_model.dart';

class RouteGenerator{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
static Route<dynamic> onGenerator(RouteSettings setting){
  Object? arg = setting.arguments;
  switch(setting.name){
    case Routes.movieDetailScreen:
      return MaterialPageRoute(builder: (_)=>MovieDetailScreen(movieItem:arg as Results));
    case Routes.tvDetailScreen:

      return MaterialPageRoute(builder: (_)=>TvDetailscreen(tvShow:arg as TvShow));

  case Routes.actorDetailScreen:
  return MaterialPageRoute(builder: (_)=>ActorDetailScreen(cast:arg as Cast));

    default:
      return MaterialPageRoute(builder: (_)=>Scaffold());
  }
}
}