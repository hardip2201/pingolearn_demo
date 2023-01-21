import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/view/home_screen.dart';
import 'package:pingolearn_round/view/signup_screen.dart';
import 'package:pingolearn_round/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFF5F9FD),
        appBar: AppBar(
          backgroundColor: Color(0xFFFF5F9FD),
          title: Text(
            'Comments',
            style: TextStyle(
              fontFamily: 'Poppins-Bold',
              color: Color(0xFF0C54BE),
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
        ),
        body: GetBuilder<LoginViewModel>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Container(
                  height: Get.height * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.2),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: controller.email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter email';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: controller.password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter password';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.signIn(
                                  email: controller.email.text,
                                  password: controller.password.text);
                            }
                          },
                          child: Container(
                            width: Get.width * 0.5,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Color(0xFF3B72AF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Signup',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {Get.off(SignUpScreen())},
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF3B72AF),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
