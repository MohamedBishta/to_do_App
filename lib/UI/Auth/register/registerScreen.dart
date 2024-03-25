import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Core/Providers/AuthProvider.dart';
import 'package:to_do_list/Core/Utilites/firebase_error_codes.dart';
import 'package:to_do_list/Core/Utilites/myValidation.dart';
import 'package:to_do_list/Core/firestore_helper.dart';
import 'package:to_do_list/UI/Auth/Login/Login.dart';
import 'package:to_do_list/UI/Componant/CustomTextFormField.dart';
import 'package:to_do_list/Model/user.dart' as MyUser;
import '../../../Core/Utilites/dialog_Details.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? fullNameController = TextEditingController();

  TextEditingController? emailController = TextEditingController();

  TextEditingController? ageController = TextEditingController();

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
                      labelText: "Age :",
                    ),
                    validator: (age) {
                      if (age == null || age.trim().isEmpty)
                        return "Please Enter Vaild Age ";
                    },
                    controller: ageController,
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
                      if (password == null || password.isEmpty)
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
                    validator: (confpassword) {
                      if (confpassword == null || confpassword.isEmpty) {
                        return "Please Enter Vaild Password";
                      }
                      if (confpassword != passwordController) {
                        return "Password doesn't match";
                      }
                      MyValidations.validatePassword(confpassword);
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
                    onPressed: () async {
                      isValidate();
                      try {
                        AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
                        DialogUtils.showLoadingDialog(context: context);
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailController!.text.trim(),
                          password: passwordController!.text,
                        );
                        provider.authUser = credential.user;
                        MyUser.User databaseUser = MyUser.User(
                          id: credential.user!.uid,
                          fullname: fullNameController!.text,
                          age: int.parse(ageController!.text),
                          email: emailController!.text,
                        );
                        provider.databaseUser = databaseUser;
                        await FirestoreHelper.addNewUser(databaseUser);
                        DialogUtils.hidenDialog(context: context);
                        DialogUtils.showErrorDialog(
                            context: context,
                            message:
                                "Register successfuly ${credential.user!.uid}",
                            positiveTitle: "ok",
                            positiveClick: () {
                              DialogUtils.hidenDialog(context: context);
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            });
                      } on FirebaseAuthException catch (e) {
                        DialogUtils.hidenDialog(context: context);
                        if (e.code == ErrorCodes.weakPassword) {
                          DialogUtils.showErrorDialog(
                              context: context,
                              message: "The pas sword provided is too weak.",
                              positiveTitle: "ok",
                              positiveClick: () {
                                DialogUtils.hidenDialog(context: context);
                              });
                        } else if (e.code == ErrorCodes.emailExist) {
                          DialogUtils.showErrorDialog(
                              context: context,
                              message:
                                  'The account already exists for that email.',
                              positiveTitle: "ok",
                              positiveClick: () {
                                DialogUtils.hidenDialog(context: context);
                              });
                        }
                      } catch (e) {
                        DialogUtils.hidenDialog(context: context);
                        DialogUtils.showErrorDialog(
                            context: context,
                            message: e.toString(),
                            positiveTitle: "ok",
                            positiveClick: () {
                              DialogUtils.hidenDialog(context: context);
                            });
                      }
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
  }
}
