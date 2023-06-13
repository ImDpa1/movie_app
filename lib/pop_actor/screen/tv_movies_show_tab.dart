import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/tv/bloc/tv_cast/tv_cast_bloc.dart';
import 'package:new_app/tv/model/tv_module.dart';
import '../../movie/movie_model/movie_module.dart';
import '../../tv/model/tv_cast_model.dart';
import '../../utils/apis.dart';
import '../../utils/app_color.dart';
import '../../utils/routes.dart';
import '../actor_model/shows_model.dart';

class MoviesTvShowsScreen extends StatefulWidget {
  final String actorId;

  const MoviesTvShowsScreen({Key? key, required this.actorId})
      : super(key: key);

  @override
  State<MoviesTvShowsScreen> createState() => _MoviesTvShowsScreenState();
}

class _MoviesTvShowsScreenState extends State<MoviesTvShowsScreen> {
  @override
  void initState() {
    BlocProvider.of<TvCastBloc>(context)
        .add(FetchActorShowsEvent(id: widget.actorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvCastBloc, TvCastStateImp>(
      builder: (context, state) {
        if (state.status == TvCastStatus.showFetchsuccess)
          return GridView.builder(
            itemCount: state.combinedCreditList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemBuilder: (context, index) {
              return _showsView(state.combinedCreditList[index]);
            },
          );
        else if (state.status == TvCastStatus.showFetchfailure)
          return Container(
            alignment: Alignment.center,
            child: Text("Something Went Wrong"),
          );
        else
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  Widget _showsView(ShowsCast cast) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
            onTap: () {
              if (cast.mediaType == "tv") {
                Navigator.pushNamed(context, Routes.tvDetailScreen,
                    arguments: Results(id: cast.id, title: cast.name));
              } else if (cast.mediaType == "movie") {
                Navigator.pushNamed(context, Routes.tvDetailScreen,
                    arguments: TvShow(id: cast.id, name: cast.name));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [BoxShadow(spreadRadius: 0.1)]),
              child: Column(
                children: [
                  if (cast.posterPath != null)
                    Image.network(
                      Apis.imgHeader +
                          (cast.mediaType == "movie"
                              ? cast.posterPath.toString()
                              : cast.backdropPath.toString()),
                      height: 55,
                      width: double.infinity,
                      errorBuilder: (context, _, trace) {
                        return Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: Text("No Image"),
                        );
                      },
                      fit: BoxFit.fill,
                    ),
                  SizedBox(
                    height: 2,
                  ),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      cast.mediaType == "movie"
                          ? cast.title.toString()
                          : cast.name.toString(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
            )));
  }
}
