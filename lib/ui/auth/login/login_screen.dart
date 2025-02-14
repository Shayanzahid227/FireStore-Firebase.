import 'package:code_structure/core/constants/app_assest.dart';
import 'package:code_structure/custom_widgets/line_with_text.dart';
import 'package:code_structure/custom_widgets/login_button.dart';
import 'package:code_structure/custom_widgets/social_button.dart';
import 'package:code_structure/custom_widgets/textforem_field.dart';
import 'package:code_structure/ui/auth/login/login_view_model.dart';
import 'package:code_structure/ui/auth/sigUp/sign_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenViewModel(),
      child: Consumer<LoginScreenViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 33,
                  right: 33,
                  top: 93,
                ),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Log into  ",
                          style: GoogleFonts.sansita(fontSize: 25),
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
                      70.verticalSpace,

                      ///
                      ///     text field for email
                      ///
                      customtextformfeild(
                        // onChanged: (value) {
                        //   emailController.text = value;
                        // },
                        controller: model.emailController,
                        text: "Email address",
                        obscureText: false,
                        validator: model.validateEmail,
                      ),
                      20.verticalSpace,

                      ///
                      ///     text field for password
                      ///
                      customtextformfeild(
                        // onChanged: (value) {
                        //   passwordController.text = value;
                        // },
                        controller: model.passwordController,
                        text: "Password", obscureText: false,
                        validator: model.validatePassword,
                        //obscureText: false,
                      ),
                      30.verticalSpace,

                      45.0.verticalSpace,
                      GestureDetector(
                        onTap: () {},
                        child: CustomloginButton(
                          loading: model.loading,
                          text: "LOG IN",
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              ///
                              /// function to login user if he/she is already signUp declared on the top
                              ///************** */
                              model.login();

                              /// *****************/
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => HomeScreen(),
                              //   ),
                              // );
                            }
                          },
                        ),
                      ),
                      10.verticalSpace,
                      CustomLineWithText(text: "or Log in with"),
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
                      80.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?  "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: Text("Sign Up"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
