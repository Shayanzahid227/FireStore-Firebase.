import 'dart:ui_web';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/core/enums/view_state_model.dart';
import 'package:code_structure/core/others/base_view_model.dart';
import 'package:code_structure/ui/home/home_screen.dart';
import 'package:code_structure/utils/toast_messaage_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginScreenViewModel extends BaseViewModel {
  bool loading = false;

  ///
  ///  user registration in firebase
  ///

  BuildContext get context => context;
  final auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final User = auth.currentUser;
    try {
      // setState(ViewState.busy);
      loading = true;
      notifyListeners();

      await auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then(
        (value) {
          // setState(ViewState.idle);
          loading = false;
          notifyListeners();

          Utils().ToastMessage(
            'login verified',
          );
          Get.to(
            HomeScreen(),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomeScreen(),
          //   ),
          // );
        },
      ).onError(
        (error, stackTrace) {
          //  setState(ViewState.idle);
          loading = false;
          notifyListeners();

          // normal print statement slow app use debugprint
          debugPrint('login failed');
          Utils().ToastMessage(
            error.toString(),
          );
        },
      );
    } catch (e) {
      // for de bugging this will be display in console
      print("User can not found $e");
      // setState(ViewState.idle);
      loading = false;
      notifyListeners();
    }
  }

  final formKey = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  ///
  ///function for validation
  ///
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty || !emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }
}
