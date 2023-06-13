import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/apis.dart';
import '../../utils/app_color.dart';
import '../../utils/routes.dart';
import '../bloc/movie_bloc.dart';
import '../movie_model/movie_module.dart';


class MovieScreen extends StatefulWidget {

  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    BlocProvider.of<MovieBloc>(context).add(FetchMovieEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<MovieBloc>(context)..add(LoadingEvent())..add(FetchMovieEvent());

      },
      child: BlocBuilder<MovieBloc, MovieStateImp>(
        builder: (context, state) {
          if (state.status == MovieStatus.success) {
            List<Results> movieList = [];
            if(state.movieModule.results !=null){
              for(var i in state.movieModule.results!){
                if(i.posterPath!=null){
                  movieList.add(i);
                }
              }
            }
            // List<Results> movieList = state.movieModule.results ?? [];
            return GridView.builder(
                itemCount: movieList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return _movieView(movieList[index]);
                });
          }
          else if (state.status == MovieStatus.failure)
            return Container(
              alignment: Alignment.center,
              child: Text("Something Wrong!"),
            );
          else
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }


  Widget _movieView(Results data) {
    return InkWell(
      onTap: (){


        Navigator.pushNamed(context, Routes.movieDetailScreen,arguments: data);
      },

    child: Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [BoxShadow(spreadRadius: 0.1)]
      ),
      child: Column(
        children: [
          Image.network(Apis.imgHeader + data.posterPath.toString(),height: 55,fit:BoxFit.fitWidth,),
          SizedBox(height: 2,),
          Center(child: Padding(padding: EdgeInsets.all(5),
            child: Text(data.title.toString(), maxLines: 2,textAlign:TextAlign.center,),
          )
          ),
        ],
      ),
    ));
  }
}

