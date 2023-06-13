
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/apis.dart';
import '../utils/app_color.dart';
import '../utils/routes.dart';
import 'bloc/tv_bloc.dart';
import 'model/tv_module.dart';
class TvScreen extends StatefulWidget {
  const TvScreen({Key? key}) : super(key: key);
  @override
  State<TvScreen> createState() => _TvScreenState();
}
class _TvScreenState extends State<TvScreen> {
  @override
  void initState() {
  BlocProvider.of<TvBloc>(context).add(FetchTvEvent());
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<TvBloc>(context)..add(LoadingEvent())..add(FetchTvEvent());
      },
      child: BlocBuilder<TvBloc, TvStateImp>(
        builder: (context, state) {
          if (state.status == TvStatus.success) {
            List<TvShow> movieList = [];
            if(state.tvModule.tvShow !=null){
              for(var i in state.tvModule.tvShow!){
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
          else if (state.status == TvStatus.failure)
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
  Widget _movieView(TvShow data) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.tvDetailScreen,arguments: data);
      },
    child: Padding(padding: EdgeInsets.all(5),
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
              child: Text(data.name.toString(), maxLines: 2,textAlign:TextAlign.center,),
            )
            ),
          ],
        ),
      ),)
    );
  }
}
