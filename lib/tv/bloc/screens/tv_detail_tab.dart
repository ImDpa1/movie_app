import 'package:flutter/cupertino.dart';
import 'package:new_app/tv/model/tv_detail_model.dart';

import '../../../utils/app_color.dart';

class TvDetailtab extends StatefulWidget {
  final TvDetailModule detail;
  const TvDetailtab({Key? key,required this.detail}) : super(key: key);

  @override
  State<TvDetailtab> createState() => _TvDetailtabState();
}

class _TvDetailtabState extends State<TvDetailtab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _customCardView(title: "Seasons",
                    value: widget.detail.numberOfSeasons.toString())),
                SizedBox(width: 5,),
                Expanded(child: _customCardView(title: "Episode",
                    value: widget.detail.numberOfEpisodes.toString())),
                SizedBox(width: 5,),
                Expanded(child: _customCardView(title: "Last Air Date",
                    value: widget.detail.lastAirDate.toString())),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: _customCardView(title: "Type",
                    value: widget.detail.type.toString())),
                SizedBox(width: 6,),
                Expanded(child: _customCardView(title: "Status",
                    value: widget.detail.status))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _customCardView(title: "Overview",
                value: widget.detail.overview),
          ),
        ],
      ),
    );
  }
  Widget customCardView({ required String title, String? value}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.whiteColor,
        boxShadow: [BoxShadow(spreadRadius: 0.2)],
      ),
    );
  }
  Widget _customCardView({ required String title,  String? value}){
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.whiteColor,
        boxShadow: [BoxShadow(spreadRadius: 0.2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 5,),
          Text(value ?? "-"),
        ],
      ),
    );
  }
}
