
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_state.dart';
import 'package:market/helper/componants/componants.dart';
import 'package:market/helper/constant.dart';
import 'package:market/helper/dio_helper.dart';
import 'package:market/models/cart_model.dart';
import 'package:market/models/categories_model.dart';
import 'package:market/models/change_cart_item.dart';
import 'package:market/models/change_favorite.dart';
import 'package:market/models/favorite_model.dart';
import 'package:market/models/home_model.dart';
import 'package:market/models/login_model.dart';
import 'package:market/screens/home_body_screen/favorite.dart';

import '../../models/search_model.dart';
import '../../screens/home_body_screen/cart.dart';
import '../../screens/home_body_screen/categories.dart';
import '../../screens/home_body_screen/products.dart';
import '../../screens/home_body_screen/settings.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Map<int, bool> favorites = {};
  Map<int, bool> inCart = {};

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = const [
    Products(),
    Categories(),
    Favorite(),
    Cart(),
    Settings()
  ];
  List<String> titles = ['My Market','Categories','Favorite','Cart','Settings'];

  changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeIndexState());
  }

  CategoriesModel? categoriesModel;
  getCategories() {
    emit(ShopGetCategoriesLoadingState());

    DioHelper.getData(url: kEndPointCategories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopGetCategoriesSuccessState());
    })
        //  print(value.data);

        .catchError((e) {
      print(e.toString());
      emit(ShopGetCategoriesFailureState());
    });
  }

  HomeModel? homeModel;
  getHome() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: kEndPointHome, token: token).then((value) {
      //  print(value.data);
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      homeModel!.data!.products.forEach((element) {
        inCart.addAll({element.id: element.inCart});
      });

      emit(ShopHomeSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopHomeFailureState());
    });
  }

  FavoriteModel? favoriteModel;
  getFavorite() {
    emit(ShopGetFavoriteLoadingState());
    DioHelper.getData(url: kEndPointFavorites, token: token).then((value) {
      // print(value.data);
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(ShopGetFavoriteSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopGetFavoriteFailureState());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;
  changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteVisibleState());
    DioHelper.postData(
        url: kEndPointFavorites,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      if (!changeFavouriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
        buildToast(
            message:
                'Can\'t add this product to favourite, Something went wrong',
            state: ToastState.ERORR);
      } else {
        getFavorite();
        emit(ShopGetFavoriteSuccessState());
      }
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      buildToast(
          message: 'Can\'t add this product to favourite, Something went wrong',
          state: ToastState.ERORR);
      print(error.toString());
      emit(ShopChangeFavoriteFailureState());
    });
  }

  CartModel? cartModel;
  getCart() {
    emit(ShopGetCartLoadingState());
    DioHelper.getData(url: kEndPointCarts, token: token).then((value) {
      print(value.data);
      cartModel = CartModel.fromJson(value.data);
      emit(ShopGetCartSuccessState());
    }).catchError((e) {
      print(' Error in get cart ${e.toString()}');
      emit(ShopGetCartFailureState());
    });
  }

  ChangeCartItemModel? changeCartItemModel;
  changeItemCart(int productId) {
    inCart[productId] = !inCart[productId]!;
    emit(ShopChangeCartVisibleState());
    DioHelper.postData(
        url: kEndPointCarts,
        token: token,
        data: {'product_id': productId}).then((value) {
      //  print(value.data);
      changeCartItemModel = ChangeCartItemModel.fromJson(value.data);
      if (!changeCartItemModel!.status) {
        inCart[productId] = !inCart[productId]!;
        buildToast(
            message: 'Can\'t add this product to cart, Something went wrong',
            state: ToastState.ERORR);
      } else {
        getCart();
      }
      emit(ShopGetCartSuccessState());
    }).catchError((e) {
      inCart[productId] = !inCart[productId]!;
      buildToast(
          message: 'Can\'t add this product to cart, Something went wrong',
          state: ToastState.ERORR);
      print(' Error adding to cart ${e.toString()}');
      emit(ShopChangeCartFailureState());
    });
  }

  LoginModel? userData;
  getProfile() {
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(url: kEndPointProfile, token: token).then((value) {
      // print(value.data);
      userData = LoginModel.fromJson(value.data);
      emit(ShopGetProfileSuccessState());
    }).catchError((error) {
      print(' Error to get user data ${error.toString()}');
      emit(ShopGetProfileFailureState());
    });
  }

  updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
        url: kEndPointUpdateProfile,
        token: token,
        data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      //  print(value.data);
      userData = LoginModel.fromJson(value.data);
      emit(ShopUpdateProfileSuccessState());
    }).catchError((error) {
      print(' Error to update user data ${error.toString()}');
      emit(ShopUpdateProfileFailureState());
    });
  }

  SearchModel? searchModel;
  searchProduct({required String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: kEndPointSearch, data: {'text': text})
        .then((value) {
      print(value.data);
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState(searchModel: searchModel!));
    }).catchError((error) {
      print(' Error when search ${error.toString()}');
      emit(ShopSearchFailureState());
    });
  }
}
