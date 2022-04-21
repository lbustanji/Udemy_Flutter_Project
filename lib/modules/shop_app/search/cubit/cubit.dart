import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/models/shop_app/search_model.dart';
import 'package:udimy_flutter/modules/shop_app/search/cubit/states.dart';
import 'package:udimy_flutter/shared/components/constants.dart';
import 'package:udimy_flutter/shared/network/end_points.dart';
import 'package:udimy_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      authorization: token,
      data: {
        'text': text,
      },
    )?.then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
