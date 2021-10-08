import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/search_model.dart';
import 'package:shop/modules/shop_app/search/cubit/state.dart';
import 'package:shop/shared/components/constains.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value){
      model=SearchModel.fromJson(value.data);
      print(model);
      emit(SearchSuccessState());
    }).catchError((error){

      emit(SearchErrorState());
    });

  }
}
