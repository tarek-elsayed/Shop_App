import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop/layout/shop_app/cubit/states.dart';
import 'package:shop/model/favourites_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavouritesState,
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favouritesModel.data.data[index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favouritesModel.data.data.length,
            ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget buildFavItem(FavoritesData favoritesData,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${favoritesData.product.image}"),
                height: 120.0,
                width: 120.0,

              ),
              if (favoritesData.product.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  '${favoritesData.product.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.4,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${favoritesData.product.price.round()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (favoritesData.product.discount != 0)
                      Text(
                        '${favoritesData.product.oldPrice.round()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(favoritesData.product.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        ShopCubit.get(context).favourite[favoritesData.product.id]
                            ? defaultColor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_outline,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
