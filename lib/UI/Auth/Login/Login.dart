import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Utilites/dialog_Details.dart';
import 'package:to_do_list/Core/Utilites/firebase_error_codes.dart';
import 'package:to_do_list/Core/Utilites/myValidation.dart';
import 'package:to_do_list/UI/Auth/register/registerScreen.dart';
import 'package:to_do_list/UI/homePage.dart';

import '../../../Core/Providers/AuthProvider.dart';
import '../../../Core/firestore_helper.dart';
import '../../Componant/CustomTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? passwordController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    decoration: InputDecoration(
                      labelText: "Email :",
                    ),
                    validator: (email) {
                      if (email == null || email.trim().isEmpty)
                        return "Please Enter Vaild Email";
                      MyValidations.isVaildEmail(email);
                    },
                    controller: emailController,
                  ),
                  CustomTextFormField(
                    decoration: InputDecoration(
                      labelText: "Password :",
                    ),
                    validator: (password) {
                      if (password == null || password.trim().isEmpty)
                        return "Please Enter Vaild Password";
                      MyValidations.validatePassword(password);
                      if (password.length < 6) {
                        return "Password must be at least 6 characters long";
                      }
                    },
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      isValidate();
                      await login();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.routeName);
                      },
                      child: Text("don't have an account"))
                ],
              ),
            ),
          ),
        ));
  }

  void isValidate() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
  Future <void> login() async{
    try {
      AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
      DialogUtils.showLoadingDialog(context: context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController!.text.trim(),
          password: passwordController!.text);
      provider.authUser = credential.user;
      provider.databaseUser = await FirestoreHelper.getUser(credential.user!.uid);
      DialogUtils.hidenDialog(context: context);
      DialogUtils.showErrorDialog(
        context: context,
        message: 'Login Successfully ${credential.user!.uid}',
        positiveTitle: "ok",
        positiveClick: () {
          DialogUtils.hidenDialog(context: context);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hidenDialog(context: context);
      if (e.code == ErrorCodes.userNotFound) {
        DialogUtils.showErrorDialog(
          context: context,
          message: 'No user found for that email.',
          positiveTitle: "ok",
          positiveClick: () {
            DialogUtils.hidenDialog(context: context);
          },
        );
      } else if (e.code == ErrorCodes.wrongPassword) {
        DialogUtils.showErrorDialog(
          context: context,
          message: 'Wrong password provided for that user.',
          positiveTitle: "ok",
          positiveClick: () {
            DialogUtils.hidenDialog(context: context);
          },
        );
      }
    }
  }
}
