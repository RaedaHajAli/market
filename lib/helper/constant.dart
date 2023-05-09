import 'package:flutter/material.dart';

import '../on_boarding/on_boarding_model.dart';

const kPrimaryColor = Color(0xff784999);
const kSecondaryColor = Color(0xffC92E7C);

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      image: 'assets/images/onboarding_1.jpg', title: 'Explore many products'),
  OnBoardingModel(
      image: 'assets/images/onboarding_2.jpg', title: 'Choose and checkout'),
  OnBoardingModel(
      image: 'assets/images/onboarding_3.jpg', title: 'Get it delivered'),
];
String kToken = 'kToken';
String kOnboarding = 'kOnboarding';
String kEndPointLogin = 'login';
String kEndPointRegister = 'register';
String kEndPointCategories = 'categories';
String kEndPointHome = 'home';
String  kEndPointFavorites = 'favorites';
String  kEndPointCarts = 'carts';
String  kEndPointProfile = 'profile';
String  kEndPointUpdateProfile = 'update-profile';
String  kEndPointSearch = 'products/search';



String? token;
const List<String> images = [
  'https://student.valuxapps.com/storage/uploads/banners/1680055989g181K.37.PNG',
  'https://student.valuxapps.com/storage/uploads/banners/1680057283HBnq8.40.PNG',
  'https://student.valuxapps.com/storage/uploads/banners/1680056998oqIZP.38.PNG'
];
