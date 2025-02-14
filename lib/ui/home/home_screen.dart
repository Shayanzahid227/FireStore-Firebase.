import 'package:code_structure/custom_widgets/login_button.dart';
import 'package:code_structure/ui/auth/sigUp/sign_up_screen.dart';
import 'package:code_structure/ui/profile/edit_profile.dart';
import 'package:code_structure/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  Get.to(
                    SignInScreen(),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_sharp)),
          ),
          Center(child: Text("home screen")),
          50.verticalSpace,
          CustomloginButton(
              text: 'profile screen',
              onPressed: () {
                Get.to(ProfileScreen());
              })
        ],
      ),
    );
  }
}
