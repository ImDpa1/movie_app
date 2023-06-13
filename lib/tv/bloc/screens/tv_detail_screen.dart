import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:new_app/custom_widget/custom_app_bar.dart';
import 'package:new_app/tv/bloc/screens/tv_cast_tab.dart';
import 'package:new_app/tv/bloc/screens/tv_detail_tab.dart';
import 'package:new_app/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:new_app/tv/model/tv_module.dart';
import '../../../movie/movie_model/backdrop_file_model.dart';
import '../../../utils/apis.dart';
import '../../../utils/app_color.dart';


class TvDetailscreen extends StatefulWidget {
  final TvShow tvShow;

  const TvDetailscreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  State<TvDetailscreen> createState() => _TvDetailscreenState();
}

class _TvDetailscreenState extends State<TvDetailscreen>with SingleTickerProviderStateMixin{
  List<Backdrops> filePathList = [];
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    fetchFilePath();
    BlocProvider.of<TvDetailBloc>(context).add(
        FetchTvDetailEvent(id: widget.tvShow.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppBar(
            title: widget.tvShow.name
        ),

        body: BlocBuilder<TvDetailBloc, TvDetailStateImp>(
          builder: (context, state){
        if (state.status == TvDetailStatus.success) {

          String genre = "";
          if (state.tvDetailModule.genres != null) {
            state.tvDetailModule.genres!.forEach((element) {
              genre = genre +
                  (genre.isNotEmpty ? " ," : "") +
                  element.name.toString();
            });
          }
          return Column(
            children: [
              if (filePathList.length > 0)
                CarouselSlider(
                  options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.1),
                  items: filePathList.map((e) {
                    return Image.network(
                      Apis.imgHeader + e.filePath.toString(),
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                )
              else
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: CircularProgressIndicator(),
                ),
              SizedBox(
                height: 10,
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
                              state.tvDetailModule.posterPath.toString(),
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
                                  state.tvDetailModule.name.toString(),
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                SizedBox(height: 10,),
                                if (state.tvDetailModule.genres != null)
                                  Text(
                                    "Geners: genre",
                                    style: TextStyle(color: AppColors.whiteColor),
                                  ),
                                SizedBox(height: 10,),
                                Text("Original Language: ${state.tvDetailModule
                                    .originalLanguage}",
                                  style: TextStyle(color: AppColors.whiteColor),),
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
                      Tab(text: "Detail",),
                      Tab(text: "Cast",),
                    ])
                  ],
                ),
              ),
              Expanded(
              child:TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                TvDetailtab(detail: state.tvDetailModule,),
                TvCastTab(tvShowId: state.tvDetailModule.id.toString()),
              ])),

              SizedBox(height: 10,),
            ],
          );
        }

        else if (state.status == TvDetailStatus.failure)
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
      var url = Apis.tv + widget.tvShow.id.toString() + Apis.imgLastUrl;
      Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        ImageModel imageModel = ImageModel.fromJson(jsonBody);
        if (imageModel.backdrops != null) {
          filePathList = imageModel.backdrops!;
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
