import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tastee_food_app/PagesAfterSignedIn/home_page.dart';

//creating provider
class LoginAuthProvider with ChangeNotifier{

  static Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp  = RegExp(LoginAuthProvider.pattern.toString());
  UserCredential? userCredential;
  bool loading = false;
  void loginPageValidation({required TextEditingController? email,
    required TextEditingController? password,
    required BuildContext context,

  }) async{

    if (!regExp.hasMatch(email!.text.trim())){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email is invalid'),
          )
      );
      return;
    }
    else if (password!.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password should not be empty'),
          )
      );
      return;
    }
    else if (password.text.trim().length <= 8){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password must be 8 characters long'),
          )
      );
      return;
    }
    else{
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text,
            password: password.text
        ).then((value) {
          loading = false;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePage()
              )
          );
        });

      }

      on FirebaseAuthException catch(e) {
        loading = false;
        notifyListeners();
        if (e.code == "user-not-found"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('user-not-found'),
              )
          );
        }
        else if(e.code == "wrong-password"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('wrong-password'),
              )
          );

        }

      }

      }

    }

  }
