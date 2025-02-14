import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/core/constants/text_style.dart';
import 'package:code_structure/core/others/base_view_model.dart';
import 'package:code_structure/core/services/auth_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.teal,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder(
                stream: FirebaseAuth.instance.currentUser!.uid != null
                    ? FirebaseFirestore.instance
                        .collection('profileUpdate')
                        .doc(currentUser!.uid)
                        .snapshots()
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('no data found yet'),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.verticalSpace,
                      Text("Your Account information "),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "Name: ",
                            style: style14B,
                          ),
                          Text(
                            snapshot.data!.data()!['name'].toString(),
                            style: style14,
                          )
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "DOB: ",
                            style: style14B,
                          ),
                          Text(
                            snapshot.data!.data()!['birthday'].toString(),
                            style: style14,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "email: ",
                            style: style14B,
                          ),
                          Text(
                            snapshot.data!.data()!['email'].toString(),
                            style: style14,
                          )
                        ],
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            "bio: ",
                            style: style14B,
                          ),
                          Text(
                            snapshot.data!.data()!['bio'].toString(),
                            style: style14,
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
