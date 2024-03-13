import 'package:flutter/material.dart';
import 'package:to_do_list/UI/Auth/Login/Login.dart';
import 'package:to_do_list/UI/Auth/register/registerScreen.dart';
import 'package:to_do_list/UI/homePage.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute: HomePage.routeName,
      routes: {
        RegisterScreen.routeName:(context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        HomePage.routeName:(context) => HomePage(),
      },
    );
  }
}
