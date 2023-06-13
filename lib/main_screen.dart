import 'package:flutter/material.dart';
import 'package:new_app/pop_actor/pop_actor_screen.dart';
import 'package:new_app/tv/tv_screen.dart';
import 'package:new_app/utils/app_color.dart';

import 'custom_widget/custom_app_bar.dart';
import 'movie/screens/movie_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  List<String> _tabs = ["Movie","Tv", "Popular Actor"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: customAppBar(title: 'Movie App', bottomWidget:
        TabBar(
            unselectedLabelColor: AppColors.whiteColor,
            labelColor: AppColors.orangeColor,
            indicatorColor: AppColors.orangeColor,
            tabs: _tabs.map((e) {
              return Tab(text: e,);
            }).toList()
        ),
        ),
        body: TabBarView(children: [
          MovieScreen(),
          TvScreen(),
          PopActorScreen(),
        ]),
      ),
    );
  }
}
