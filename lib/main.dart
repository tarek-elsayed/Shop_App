
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shop/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/login_screen.dart';

import 'package:shop/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/components/constains.dart';


import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

import 'package:shop/shared/network/remote/dio_helper.dart';

import 'package:shop/shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool isDark = CacheHelper.getData(key: "isDark");
  bool onBoarding = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: "token");

  if(onBoarding !=null){
    if(token!=null){
      widget=ShopLayout();
    }
    else widget=ShopLoginScreen();
  }
  else widget=OnBoardingScreen();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.isDark,this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (context) => ShopCubit()..getHomeData()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            theme:lightTheme ,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget ,
          );
        },
      ),
    );
  }
}
