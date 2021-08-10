import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop/model/categories_model.dart';
import 'package:shop/model/favourites_model.dart';
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
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favourite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourite.addAll({
          element.id: element.inFavourites,
        });
      });
      print(favourite.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  FavouritesModel favouritesModel;

  void changeFavorites(int productId) {
    favourite[productId] = !favourite[productId];
    emit(ShopSuccessFavouritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      // token: token,
    ).then((value)
    {
      favouritesModel = FavouritesModel.fromJson(value.data);
      print(value.data);

      if(!favouritesModel.status){
        favourite[productId] = !favourite[productId];
      }

      emit(ShopSuccessChangeFavouritesState(favouritesModel));

    }).catchError((error) {
      favourite[productId] = !favourite[productId];

      emit(ShopErrorFavouritesState());
    });
  }
}
