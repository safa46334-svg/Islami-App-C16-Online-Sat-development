// import 'package:flutter/cupertino.dart';
// import 'package:islami_app_online_sat/features/main_layout/main_layout.dart';
// import 'package:islami_app_online_sat/features/splash/splash_screen.dart';
// import 'package:islami_app_online_sat/features/sura_detals/sura_details.dart';
//
// class RoutesManager {
//   static const String splash = "/splash";
//   static const String onBoarding = "/onBoarding";
//   static const String mainLayout = "/mainLayout";
//   static const String suraDetails = "/suraDetails";
//
//   static Map<String, WidgetBuilder> routes = {
//     splash:(context)=> SplashScreen(),
//     mainLayout:(context)=> MainLayout(),
//     suraDetails : (context)=>SuraDetails(),
//   };
// }
import 'package:flutter/material.dart';
import 'package:islami_app_online_sat/features/main_layout/main_layout.dart';
import 'package:islami_app_online_sat/features/splash/splash_screen.dart';
import 'package:islami_app_online_sat/features/sura_detals/sura_details.dart';

import '../../Onboarding Screens.dart';

class RoutesManager {
  static const String splash = "/splash";
  static const String onBoarding = "/onBoarding";
  static const String mainLayout = "/mainLayout";
  static const String suraDetails = "/suraDetails";

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onBoarding: (context) => const OnboardingScreen(),
    mainLayout: (context) => MainLayout(),
    suraDetails: (context) => const SuraDetails(),
  };
}


