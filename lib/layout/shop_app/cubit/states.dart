import 'package:shop/model/favourites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates {
  final FavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorFavouritesState extends ShopStates {}
