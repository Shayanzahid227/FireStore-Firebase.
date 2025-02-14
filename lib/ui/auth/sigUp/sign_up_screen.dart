import 'package:code_structure/core/constants/app_assest.dart';

import 'package:code_structure/custom_widgets/line_with_text.dart';
import 'package:code_structure/custom_widgets/login_button.dart';

import 'package:code_structure/custom_widgets/social_button.dart';

import 'package:code_structure/custom_widgets/textforem_field.dart';
import 'package:code_structure/ui/auth/login/login_screen.dart';
import 'package:code_structure/ui/auth/sigUp/sign_up_view_model.dart';
import 'package:code_structure/ui/home/home_screen.dart';
import 'package:code_structure/ui/profile/profile_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignInViewModel(),
        child: Consumer<SignInViewModel>(
          builder: (context, model, child) => Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 93,
                ),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Creat ",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      20.verticalSpace,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Your account",
                          style: GoogleFonts.sansita(fontSize: 25),
                        ),
                      ),
                      30.verticalSpace,

                      ///
                      ///  text feild for name
                      ///
                      customtextformfeild(
                        text: "Enter your name",
                        obscureText: false,
                        controller: model.nameCOntroller,
                        validator: model.validateName,
                      ),
                      20.verticalSpace,

                      ///
                      ///  text feild for email
                      ///
                      customtextformfeild(
                        text: "Email address",
                        obscureText: false,
                        validator: model.validateEmail,
                        controller: model.emailController,
                      ),
                      20.verticalSpace,

                      ///
                      ///  text feild for password
                      ///
                      customtextformfeild(
                        text: "Password",
                        obscureText: false,
                        validator: model.validatePassword,
                        controller: model.passwordController,
                      ),
                      20.verticalSpace,

                      ///
                      ///  text feild for confirm password
                      ///
                      customtextformfeild(
                        text: "Confirm Password",
                        obscureText: false,
                        validator: model.validateConfirmPassword,
                        controller: model.confirmPasswordController,
                      ),
                      41.verticalSpace,
                      CustomloginButton(
                        loading: model.loading,
                        // loading: loading,

                        text: "SIGN UP",
                        onPressed: () async {
                          print("******************************");
                          print(
                              "user name : ${model.nameCOntroller.text.toString()}");
                          print(
                              "user email : ${model.emailController.text.toString()})");
                          print(
                              "user password :${model.passwordController.text.toString()}");
                          print(
                              "user confirm password :${model.confirmPasswordController.text.toString()}");
                          print("******************************");

                          if (model.formKey.currentState!.validate()) {
                            // loading        ***********
                            model.loading = true;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                          await model.signIn();

                          ///
                          ///  on submitting the sigIn screen the user data will be store in firestore
                          ///
                          model.uploadUserDataToFirestore();

                          ///
                          /// for entire user
                          ///
                          model.OrderUserList();
                        },
                      ),
                      10.verticalSpace,
                      CustomLineWithText(text: "or signup with"),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomsocialIconButton(
                              onPressed: () {}, imagePath: AppAssets().google),
                          15.horizontalSpace,
                          CustomsocialIconButton(
                              onPressed: () {}, imagePath: AppAssets().google),
                          15.horizontalSpace,
                          CustomsocialIconButton(
                              onPressed: () {}, imagePath: AppAssets().google)
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have account?  "),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInScreen()));
                              },
                              child: Text("Log in"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
