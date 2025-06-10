import 'package:code_structure/firebase_options.dart';
import 'package:code_structure/ui/auth/login/login_screen.dart';
import 'package:code_structure/ui/auth/sigUp/sign_up_screen.dart';
import 'package:code_structure/ui/home/home_screen.dart';
import 'package:code_structure/ui/profile/edit_profile.dart';
import 'package:code_structure/ui/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(394, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffFAF8F6)),

        ///
        ///   stream builder is use when a value is changing frequently as user log in or sigIn or log out
        ///
        home:
        //LogInScreen()
        // /
        // /  un comment it after compleation
        // /
        // /
        StreamBuilder(
          // auth state change mean as user log in or sign out i
          //t value changes accordingly and take action and rebuild the widget
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data != null) {
              return const HomeScreen();
            } else {
              return const LogInScreen();
              // FirebaseAuth.instance.currentUser != null
              //     ? HomeScreen()
              //     : SignInScreen(),
            }
          },
        ),
      ),
    );
  }
}
