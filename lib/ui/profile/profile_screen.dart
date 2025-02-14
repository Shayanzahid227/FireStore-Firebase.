import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/core/constants/app_assest.dart';
import 'package:code_structure/core/constants/colors.dart';
import 'package:code_structure/core/constants/text_style.dart';
import 'package:code_structure/custom_widgets/login_button.dart';
import 'package:code_structure/ui/auth/login/login_screen.dart';
import 'package:code_structure/ui/auth/sigUp/sign_up_view_model.dart';
import 'package:code_structure/ui/profile/edit_profile.dart';
import 'package:code_structure/ui/setting/account_information.dart';
import 'package:code_structure/utils/toast_messaage_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ///
  /// user sigOut function
  ///
  // Future<void> _signOut() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     print('User signed out');
  //     // Navigate to the login screen
  //     Get.replace(LogInScreen());
  //   } catch (e) {
  //     print('Error signing out: $e');
  //   }
  // }

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
        });
        // await currentUser!.delete().then((value){Utils().ToastMessage("user account")})
      } catch (e) {
        Utils().ToastMessage("Error deleting account");
      }
    }
  }

  ///
  /// get image from profile
  ///
  File? _image;
  final _picker = ImagePicker();
  void getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update the state with the new image
      });
    } else {
      print('No image selected.');
    }
  }

  // ProfileScreen();
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
                            getDeleteUserAccount().then((value) {
                              Get.to(
                                LogInScreen(),
                              );
                            });
                            // then go to user login screen as user signout
                          },
                          child: Tab(
                            child: Text('delete account'),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(AccountInformationScreen());

                            ///
                            ///  delete user account
                            ///
                          },
                          child: Tab(
                            child: Text('your account information'),
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
              // streambuilder is used when  we want to see a sudden changes as we done like we edit profile
              // and as we back every thing was updated but  but..
              //
              // if we want to just get or set data then we move towards futurebuilder
              //
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
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              ///
                              ///  dp or user image
                              ///

                              Container(
                                width: 220.w,
                                height: 220.h,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      // backgroundColor: Colors.deepPurple,
                                      radius: 50,
                                      backgroundImage: _image != null
                                          ? kIsWeb // Check if it's the web platform
                                              ? NetworkImage(_image!
                                                  .path) // Use NetworkImage for web
                                              : FileImage(
                                                  _image!) // Use FileImage for mobile
                                          : const AssetImage(
                                              'assets/default_profile.png'),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 72.0, left: 50),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.teal,
                                              shape: BoxShape.circle),
                                          child: GestureDetector(
                                            onTap: getImageFromGallery,
                                            child: Icon(Icons.edit),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Name: ",
                            style: style14.copyWith(color: blackColor),
                          ),
                          Text(
                              snapshot.data!.data()!['name'].toString() ??
                                  'set your name',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                      ),

                      ///
                      ///   birthday
                      ///
                      Row(
                        children: [
                          Text(
                            "DOB: ",
                            style: style14.copyWith(color: blackColor),
                          ),
                          Text(
                            snapshot.data!.data()!['birthday'] ??
                                'set your birthday',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Email: ",
                            style: style14.copyWith(color: blackColor),
                          ),
                          Text(
                            ///
                            ///   when ever i update my profile email are disappear ?????????????
                            ///
                            snapshot.data!.data()!['email'].toString() ??
                                'set your email',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Bio: ",
                            style: style14.copyWith(color: blackColor),
                          ),
                          Text(
                            snapshot.data!.data()!['bio'] ??
                                'set your bio', // snapshot.data!.data()!['name'],
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
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
