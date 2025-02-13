import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/core/constants/app_assest.dart';
import 'package:code_structure/core/constants/colors.dart';
import 'package:code_structure/custom_widgets/login_button.dart';
import 'package:code_structure/ui/auth/login/login_screen.dart';
import 'package:code_structure/ui/auth/login/login_view_model.dart';
import 'package:code_structure/ui/auth/sign_in/sign_in_screen.dart';
import 'package:code_structure/ui/auth/sign_in/sign_view_model.dart';
import 'package:code_structure/ui/profile/edit_profile.dart';
import 'package:code_structure/ui/settings/setting_screen.dart';
import 'package:code_structure/utils/toast_messaage_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ///
  ///  delete user account function
  ///
  final currentUser = FirebaseAuth.instance.currentUser;
  Future<void> getDeleteUserAccount() async {
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            // .collection('user').where('creator',isequalto:firebaseAuth.instance.currentUser!.uid) ----> it is also can be used
            .doc(currentUser!.uid)
            // first remove the current user data or document from firestore then signout him
            .delete()
            .then((value) {
          Utils().ToastMessage("Account was successfully deleted ");

          ///
          ///  update this
          ///
          ///
          FirebaseAuth.instance.signOut().then((value) {
            Get.to(LogInScreen());
          });
        });
        // await currentUser!.delete().then((value){Utils().ToastMessage("user account")})
      } catch (e) {
        Utils().ToastMessage("Error deleting account");
      }
    }
  }

  ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('User Profile'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: PopupMenuButton(
                  icon: Icon(Icons.settings),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            ///
                            ///  delete user account
                            ///
                            getDeleteUserAccount();
                          },
                          child: Tab(
                            child: Text('delete account'),
                          ),
                        ),
                      )
                    ];
                  },
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: StreamBuilder(
                // ! mean the current user must not be null
                // we also use ? but it is for null safety mean if null or not null but ...
                // in this case we only want a user which have not null he/she must be != null
                stream: currentUser != null
                    ? FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  // hasdata mean data != null we can also write as snapshot.data != null
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        Text(" no data yet "),
                        // to find the number of user sigIn currently
                        // Text('${snapshot.data!.docs.length}')
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 50,
                          backgroundImage: AssetImage(
                            AppAssets().google,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        snapshot.data!.data()!['name'].toString() ??
                            'set your name',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),

                      ///
                      ///   birthday
                      ///
                      Text(
                        snapshot.data!.data()!['birthday'] ??
                            'set your birthday',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ///
                        ///   when ever i update my profile email are disappear ?????????????
                        ///
                        snapshot.data!.data()!['email'].toString() ??
                            'set your email',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        snapshot.data!.data()!['bio'] ??
                            'set your bio', // snapshot.data!.data()!['name'],
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      100.verticalSpace,
                      model.loading
                          ? CircularProgressIndicator()
                          : Center(
                              child: CustomloginButton(
                                loading: false,
                                text: 'edit profile screen',
                                onPressed: () {
                                  // model.loading = true;
                                  Get.to(
                                    EditProfileScreen(),
                                  );
                                },
                              ),
                            )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
