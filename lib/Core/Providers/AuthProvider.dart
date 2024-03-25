import 'package:to_do_list/Core/firestore_helper.dart';
import 'package:to_do_list/Model/user.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUserProvider extends ChangeNotifier{
  User? authUser;
  MyUser.User? databaseUser ;

  bool isFirebaseLogedin(){
    if(FirebaseAuth.instance.currentUser != null){
      authUser = FirebaseAuth.instance.currentUser;
      return true;
    }else{
       return false;
    }
  }
  Future<void> retriveDatabaseUser()async{
    databaseUser = await FirestoreHelper.getUser(authUser!.uid) ;
  }
}