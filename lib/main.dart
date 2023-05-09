import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/cubits/shop_cubit/shop_cubit.dart';
import 'package:market/cubits/simple_bloc_observer.dart';
import 'package:market/helper/cache_helper.dart';
import 'package:market/helper/constant.dart';
import 'package:market/helper/dio_helper.dart';
import 'package:market/helper/theme_app.dart';
import 'package:market/screens/home_screen_layout.dart';
import 'package:market/screens/login_screen.dart';

import 'on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getString(key: kToken);
 
  bool onBoarding = CacheHelper.getBool(key: kOnboarding) ?? false;
  print(token);
  Widget widget;

  if (token == null) {
    if (onBoarding) {
      widget =const LoginScreen();
    } else {
      widget =const OnBoardingScreen();
    }
  } else {
    widget =const HomeScreen();
  }
  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.widget}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
      ..getCategories()
      ..getHome()
      ..getFavorite()
      ..getCart()
      ..getProfile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: widget,
      ),
    );
  }
}
