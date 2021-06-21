import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/src/logic/blocs/theme_cubit/theme_cubit.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';
import 'package:video_feed/src/ui/utils/globals.dart';

AppBar homeappBar(BuildContext context) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Video Feed',
        style: Theme.of(context).appBarTheme.textTheme!.headline1,
      ),
    ),
    backgroundColor: appTheme == AppTheme.LightTheme ? bgColor : bgColorDark,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: DayNightSwitcher(
          isDarkModeEnabled: appTheme == AppTheme.DarkTheme,
          starsColor: Theme.of(context).accentColor,
          dayBackgroundColor: Theme.of(context).primaryColor,
          onStateChanged: (isDarkModeEnabled) {
            if (isDarkModeEnabled) {
              BlocProvider.of<ThemeCubit>(context).darkTheme();
            } else {
              BlocProvider.of<ThemeCubit>(context).lightTheme();
            }
          },
        ),
      ),
    ],
  );
}
