import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/custom_widget/custom_app_bar.dart';
import 'package:new_app/pop_actor/bloc/actor_detail/actor_detail_bloc.dart';
import 'package:new_app/pop_actor/screen/tv_movies_show_tab.dart';

import '../../movie/movie_model/backdrop_file_model.dart';
import '../../tv/model/tv_cast_model.dart';
import '../../utils/apis.dart';
import '../../utils/app_color.dart';

class ActorDetailScreen extends StatefulWidget {
  final Cast cast;

  const ActorDetailScreen({Key? key, required this.cast}) : super(key: key);

  @override
  State<ActorDetailScreen> createState() => _ActorDetailScreenState();
}

class _ActorDetailScreenState extends State<ActorDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> filePathList = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    fetchFilePath();
    BlocProvider.of<ActorDetailBloc>(context)
        .add(FetchActorDetail(id: widget.cast.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(title: widget.cast.name),
        body: BlocBuilder<ActorDetailBloc, ActorDetailStateImp>(
          builder: (context, state) {
            if (state.status == ActorDetailStatus.success)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (filePathList.length > 0)
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 150,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.1),
                      items: filePathList.map((e) {
                        return Image.network(
                          Apis.imgHeader + e.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      }).toList(),
                    ),
                  Container(
                    height: 150,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              Apis.imgHeader +
                                  state.actorDetail.profilePath.toString(),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.actorDetail.name.toString(),
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "DOB : ${state.actorDetail.birthday}",
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Birth Place : ${state.actorDetail.placeOfBirth}",
                                  style: TextStyle(color: AppColors.whiteColor),
                                ),
                              ],
                            ))
                          ],
                        ),
                        TabBar(
                            controller: _tabController,
                            indicatorColor: AppColors.orangeColor,
                            labelColor: AppColors.orangeColor,
                            unselectedLabelColor: AppColors.whiteColor,
                            tabs: [
                              Tab(
                                text: "Detail",
                              ),
                              Tab(
                                text: "Movies/tv show",
                              ),
                            ]),
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whiteColor,
                              boxShadow: [BoxShadow(spreadRadius: 0.2)]),
                          child: Text(
                            state.actorDetail.biography ??
                                "Biography not found",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      MoviesTvShowsScreen(actorId: widget.cast.id.toString()),
                    ],
                  ))
                ],
              );
            else if (state.status == ActorDetailStatus.failure)
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
        ),
      ),
    );
  }

  void fetchFilePath() async {
    try {
      var url = Apis.celebs + widget.cast.id.toString() + Apis.imgLastUrl;
      Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        ImageModel imageModel = ImageModel.fromJson(jsonBody);
        if (imageModel.filePath != null) {
          filePathList = imageModel.filePath!;
          setState(() {});
        }
      } else {}
    } on SocketException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No internet")));
    } on Error catch (e) {
      print(e);
    }
  }
}
