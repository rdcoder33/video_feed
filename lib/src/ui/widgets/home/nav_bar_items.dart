import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<BottomNavyBarItem> navBarsItems(BuildContext context) {
  return [
    BottomNavyBarItem(
        textAlign: TextAlign.center,
        icon: Icon(CupertinoIcons.play_rectangle_fill),
        title: Text('Feed'),
        activeColor: Theme.of(context).primaryColor),
    BottomNavyBarItem(
        textAlign: TextAlign.center,
        icon: Icon(CupertinoIcons.star_fill),
        title: Text('Favorites'),
        activeColor: Theme.of(context).accentColor),
  ];
}
