import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/HomeLayout/home_layout.dart';
import 'package:ecommerce_eraasoft/view/screens/Login/login_screen.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:flutter/material.dart';
import '../../../view_model/data/local/shared_preference/keys.dart';
import '../../../view_model/data/local/shared_preference/shared_preferences.dart';
class EcommerceSplashScreen extends StatelessWidget {
  const EcommerceSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 5000,
        splash: Image.network('https://seeklogo.com/images/E/e-commerce-concept-logo-5146F23CC5-seeklogo.com.png'),
        splashIconSize: 500,
        nextScreen: (LocalData.get(key: SharedKeys.token)!=null)?const HomeLayOutScreen():const LoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppColors.backgroundColor);
  }
}

