 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_app/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light),
    backgroundColor: HexColor('333739'),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.white30,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739')),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white),
  ),
  fontFamily: "Jannah",
);


 ThemeData lightTheme=ThemeData(
   scaffoldBackgroundColor: Colors.white,
   primarySwatch:defaultColor,
   appBarTheme: AppBarTheme(
     titleSpacing: 20.0,
     elevation: 0,
     backwardsCompatibility: false,
     systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: Colors.white,
         statusBarIconBrightness: Brightness.dark),
     backgroundColor: Colors.white,
     titleTextStyle: TextStyle(
       color: Colors.black,
       fontSize: 20,
       fontWeight: FontWeight.bold,
     ),
     iconTheme: IconThemeData(color: Colors.black),
   ),
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
     selectedItemColor: Colors.deepOrange,
     elevation: 20.0,
     type: BottomNavigationBarType.fixed,
   ),
   textTheme: TextTheme(
     bodyText1: TextStyle(
         fontSize: 18,
         fontWeight: FontWeight.w600,
         color: Colors.white),
   ),
   fontFamily: "Jannah",

 );