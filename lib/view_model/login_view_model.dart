import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/view/home_screen.dart';

class LoginViewModel extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      Get.snackbar('Success', 'Login Successfully',
          snackPosition: SnackPosition.BOTTOM);

      Get.off(HomeScreen());
      return null;
    } on FirebaseAuthException catch (e) {
      print('--eee-${e}');
      Get.snackbar('Error', 'Please enter valid input',
          snackPosition: SnackPosition.BOTTOM);

      return null;
    }
  }
}
