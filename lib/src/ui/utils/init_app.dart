import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_feed/src/logic/blocs/fav_bloc/fav_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:video_feed/src/logic/blocs/theme_cubit/theme_cubit.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';
import 'package:video_feed/src/ui/utils/globals.dart';

initApp(BuildContext context) async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  BlocProvider.of<FavBloc>(context, listen: false).add(LoadFav());
  // ThemeState themeState =
  //     BlocProvider.of<ThemeCubit>(context, listen: false).state;
  if (appTheme == AppTheme.LightTheme) {
    await FlutterStatusbarcolor.setStatusBarColor(bgColor);
    await FlutterStatusbarcolor.setNavigationBarColor(bgColor);
    await FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  } else {
    await FlutterStatusbarcolor.setStatusBarColor(bgColorDark);
    await FlutterStatusbarcolor.setNavigationBarColor(bgColorDark);
    await FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }
}
