import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/src/logic/blocs/api_bloc/api_bloc.dart';
import 'package:video_feed/src/logic/blocs/fav_bloc/fav_bloc.dart';
import 'package:video_feed/src/logic/blocs/internet_cubit/internet_cubit.dart';
import 'package:video_feed/src/logic/blocs/theme_cubit/theme_cubit.dart';
import 'package:video_feed/src/logic/repositories/api_repository.dart';
import 'package:video_feed/src/logic/repositories/storage_repository.dart';
import 'package:video_feed/src/logic/services/api_service.dart';
import 'package:video_feed/src/logic/services/storage_service.dart';
import 'package:video_feed/src/ui/Theme/app_theme.dart';
 
import 'package:video_feed/src/ui/screens/favorites.dart';
import 'package:video_feed/src/ui/screens/video_feed.dart';
 
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:video_feed/src/ui/utils/globals.dart';
import 'package:video_feed/src/ui/utils/init_app.dart';
import 'package:video_feed/src/ui/widgets/home/home_app_bar.dart';
import 'package:video_feed/src/ui/widgets/home/nav_bar_items.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiBloc(APIRepository(APIService())),
        ),
        BlocProvider(
          create: (context) =>
              FavBloc(StorageRepo(storageService: StorageService('storage'))),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(connectivity: Connectivity()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          appTheme = state is ThemeCubitLight
              ? AppTheme.LightTheme
              : AppTheme.DarkTheme;
          initApp(context);
          return MaterialApp(
            title: 'Video Feed',
            debugShowCheckedModeBanner: false,
            theme: state is ThemeCubitLight ? lightThemeData : darkThemeData,
            home: MyHomePage(title: 'Video Feed'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget with WidgetsBindingObserver {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initApp(context);

    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // listen for internet disconnection
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetDisconnected) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('No, Interent Connection'),
                  content: Text(
                      'Video Feed requires good internet connection to work properly'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('OK'))
                  ],
                );
              });
        }
      },
      child: Scaffold(
        appBar: homeappBar(context),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _selectedIndex = index;
          },
          children: <Widget>[VideoFeed(), FavoritePage()],
        ),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _selectedIndex,
            showElevation: false,
            backgroundColor:
                appTheme == AppTheme.LightTheme ? Colors.white : Colors.black,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            onItemSelected: (index) => setState(() {
                  _selectedIndex = index;
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                }),
            items: navBarsItems(context)),
      ),
    );
  }
}
