import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop/model/home_model.dart';

import 'package:shop/modules/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/shop_app/favourites/favourites_screen.dart';
import 'package:shop/modules/shop_app/products/products_screen.dart';
import 'package:shop/modules/shop_app/settings/settings_screen.dart';
import 'package:shop/shared/components/constains.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData(){
    HomeModel homeModel;

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value){

      homeModel=HomeModel.formJson(value.data);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      emit(ShopErrorHomeDataState());
    });

  }


}


