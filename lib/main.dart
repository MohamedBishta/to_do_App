import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/UI/Auth/Login/Login.dart';
import 'package:to_do_list/UI/Auth/register/registerScreen.dart';
import 'package:to_do_list/UI/Splash/splashScreen.dart';
import 'package:to_do_list/UI/homePage.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AuthUserProvider(),
      child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        RegisterScreen.routeName:(context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        HomePage.routeName:(context) => HomePage(),
        SplashScreen.routeName:(context) => SplashScreen(),
      },
    );
  }
}
