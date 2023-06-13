import 'package:flutter/material.dart';

AppBar customAppBar({String ? title,
PreferredSizeWidget? bottomWidget}) {
  return AppBar(
      title: Text("Movie House"),
    centerTitle : true,
    bottom: bottomWidget,
  );
}