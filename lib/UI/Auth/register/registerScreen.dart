import 'package:flutter/material.dart';
import 'package:to_do_list/Core/Utilites/myValidation.dart';
import 'package:to_do_list/UI/Auth/Login/Login.dart';
import 'package:to_do_list/UI/Componant/CustomTextFormField.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? fullNameController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  TextEditingController? confirmPasswordController = TextEditingController();

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
                      labelText: "Full Name :",
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty)
                        return "Please Enter Vaild Name";
                    },
                    controller: fullNameController,
                  ),
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
                  CustomTextFormField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password :",
                    ),
                    validator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return "Please Enter Vaild Password";
                      }
                      if (password != passwordController) {
                        return "Password doesn't match";
                      }

                      MyValidations.validatePassword(password);
                    },
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      isValidate();
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: Text("Already have an account"))
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
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}