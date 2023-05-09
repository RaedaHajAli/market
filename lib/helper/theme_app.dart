import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market/helper/constant.dart';

class AppTheme {
  static light() {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: Colors.grey
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white)),
                textTheme:const TextTheme(
                  headlineLarge: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: kPrimaryColor
                  ),
                  labelMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    
                  ),
                  labelSmall:TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,

                    
                  ),
                  bodyLarge:TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                   
                  ), 
                  
                ),
                bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: kPrimaryColor,
                  backgroundColor: Colors.white,
                  
                ),
                floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: kSecondaryColor));
  }
}
