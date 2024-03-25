import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/UI/Auth/Login/Login.dart';
import 'package:to_do_list/UI/homePage.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),() {
      splashFinish();
    },);
    return Scaffold(
      backgroundColor: Color(0xffddeada),
     body: Center(
        child: Image.asset("assets/images/splash.png"),
      ),
    );

  }

  void splashFinish()async{
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
    if(provider.isFirebaseLogedin()){
      await provider.retriveDatabaseUser();
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
