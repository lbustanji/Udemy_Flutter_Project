import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/models/shop_app/categories_model.dart';
import 'package:udimy_flutter/models/shop_app/change_favorites_model.dart';
import 'package:udimy_flutter/models/shop_app/favorites_model.dart';
import 'package:udimy_flutter/models/shop_app/home_model.dart';
import 'package:udimy_flutter/models/shop_app/login_model.dart';
import 'package:udimy_flutter/modules/shop_app/categories/categories_screen.dart';
import 'package:udimy_flutter/modules/shop_app/cubit/states.dart';
import 'package:udimy_flutter/modules/shop_app/favorites/favorites_screen.dart';
import 'package:udimy_flutter/modules/shop_app/products/products_screen.dart';
import 'package:udimy_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:udimy_flutter/shared/components/constants.dart';
import 'package:udimy_flutter/shared/network/end_points.dart';
import 'package:udimy_flutter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  HomeModel? homeModel = null;
  CategoriesModel? categoriesModel = null;
  FavoritesModel? favoritesModel = null;
  ShopLoginModel? userModel;
  ChangeFavoritesModel? changeFavoritesModel = null;
  Map<int, bool> favorites = {};

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, authorization: token)!.then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, authorization: token)!.then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      authorization: token,
    )?.then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, authorization: token)!.then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      authorization: token,
    )!
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      authorization: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    )!
        .then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
