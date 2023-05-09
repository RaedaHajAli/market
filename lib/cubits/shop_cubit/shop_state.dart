// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/search_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeIndexState extends ShopStates {}

class ShopGetCategoriesLoadingState extends ShopStates {}

class ShopGetCategoriesSuccessState extends ShopStates {}

class ShopGetCategoriesFailureState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeFailureState extends ShopStates {}

class ShopGetFavoriteLoadingState extends ShopStates {}

class ShopGetFavoriteSuccessState extends ShopStates {}

class ShopGetFavoriteFailureState extends ShopStates {}

class ShopChangeFavoriteVisibleState extends ShopStates {}

class ShopChangeFavoriteFailureState extends ShopStates {}

class ShopGetCartLoadingState extends ShopStates {}

class ShopGetCartSuccessState extends ShopStates {}

class ShopGetCartFailureState extends ShopStates {}

class ShopChangeCartVisibleState extends ShopStates {}

class ShopChangeCartFailureState extends ShopStates {}

class ShopGetProfileLoadingState extends ShopStates {}

class ShopGetProfileSuccessState extends ShopStates {}

class ShopGetProfileFailureState extends ShopStates {}

class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {}

class ShopUpdateProfileFailureState extends ShopStates {}

class ShopSearchLoadingState extends ShopStates {}

class ShopSearchSuccessState extends ShopStates {
  final SearchModel searchModel;
  ShopSearchSuccessState({
    required this.searchModel,
  });
}

class ShopSearchFailureState extends ShopStates {}
