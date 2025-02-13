import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/core/others/base_view_model.dart';
import 'package:code_structure/utils/toast_messaage_error.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends ChangeNotifier {
  ///
  ///   this will use in de bugging this will print user data in console
  ///
  // String? name;
  // String? email;
  // var pasword;
  // var confirmPassword;
  //
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  ///
  /// this step will give us API exposure of registration
  ////
  TextEditingController nameCOntroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  ///
  ///  for name
  ///
  String? validateName(String? value) {
    if (value!.trim().isEmpty) {
      return 'Enter your name ';
    }
    return null;
  }

  ///
  /// for emial
  ///
  String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return 'Enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return "enter valid email e.g abc@gmail.com";
    }
    return null;
  }

  ///
  /// for password
  ///
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }

  ///
  ///for confirm password
  ///
  String? validateConfirmPassword(value) {
    if (passwordController.text != confirmPasswordController.text) {
      return 'Confirm password is incorrect ';
    }
    return null;
  }

  ////
  ///
  ///     to signin user
  ///
  ///
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signIn() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        // setState(() {
        loading = false;
        notifyListeners();
        // });
      }).onError(
        (error, stackTrace) {
          Utils().ToastMessage("successfully sigIn");
          // setState(() {
          loading = false;
          notifyListeners();
          // });
        },
      );
    } on FirebaseAuthException catch (e) {
      print("signIn Failed$e");
    }
  }

  ///
  /// upload user data to firestore
  ///
  Future<void> uploadUserDataToFirestore() async {
    print(nameCOntroller.text.toString());
    print(emailController.text.toString());
    print(passwordController.text.toString());
    final user = auth.currentUser;
    try {
      // final firestoreReference = FirebaseFirestore.instance.collection('users');
      // firestoreReference.doc(user?.uid).set(
      final userData =
          FirebaseFirestore.instance.collection("user").doc(user?.uid).set(
        {
          'id': user?.uid,
          'name': nameCOntroller.text.trim(),
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
          'date': DateTime.now().toIso8601String()
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
