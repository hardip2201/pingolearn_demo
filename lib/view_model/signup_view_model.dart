import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/view/login_screen.dart';

class SignUpViewModel extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //SIGN UP METHOD
  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      Get.snackbar('Success', 'Register Successfully',
          snackPosition: SnackPosition.BOTTOM);

      Map<String, String> userInfoMap = {
        "name": name.text,
        "email": email,
      };

      FirebaseFirestore.instance
          .collection("users")
          .doc()
          .set(userInfoMap)
          .catchError(
        (e) {
          print(e.toString());
        },
      );
      Get.off(LoginScreen());

      return null;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Please enter valid input',
          snackPosition: SnackPosition.BOTTOM);

      return null;
    }
  }
}
