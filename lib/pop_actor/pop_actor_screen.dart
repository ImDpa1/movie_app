import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movie/movie_model/movie_module.dart';
import '../tv/model/tv_cast_model.dart';
import '../utils/apis.dart';
import '../utils/app_color.dart';
import '../utils/routes.dart';
import 'actor_model/actor_module.dart';
import 'bloc/actor_bloc.dart';

class PopActorScreen extends StatefulWidget {
  const PopActorScreen({Key? key}) : super(key: key);

  @override
  State<PopActorScreen> createState() => _PopActorScreenState();
}

class _PopActorScreenState extends State<PopActorScreen> {
  @override
  void initState() {
    BlocProvider.of<ActorBloc>(context).add(FetchActorEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        BlocProvider.of<ActorBloc>(context)..add(LoadingEvent())..add(FetchActorEvent());
      },
      child: BlocBuilder<ActorBloc, ActorStateImp>(
        builder: (context, state) {
          if (state.status == ActorStatus.success) {
            List<PopActor> actorList = [];
            if (state.actorModule.popActor != null) {
              for (var i in state.actorModule.popActor!) {
                if (i.posterPath != null) {
                  actorList.add(i);
                }
              }
            }
            // List<Results> movieList = state.movieModule.results ?? [];
            return GridView.builder(
                itemCount: actorList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return _actorView(actorList[index]);
                });
          } else if (state.status == ActorStatus.failure)
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

  Widget _actorView(PopActor data) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.actorDetailScreen,
            arguments: Cast(id: data.id, name: data.name));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [BoxShadow(spreadRadius: 0.1)]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  Apis.imgHeader + data.posterPath.toString(),
                  height: 55,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 2,
                ),
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    data.name.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
