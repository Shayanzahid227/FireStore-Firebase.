import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_structure/custom_widgets/login_button.dart';
import 'package:code_structure/utils/toast_messaage_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();

  void storeUpdateProfileUserData() {
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection("profileUpdate")
          .doc(currentUser!.uid)
          .set({
        'name': _nameController.text.toString(),
        'birthday': _birthdayController.text.toString(),
        'bio': _bioController.text.toString(),
        'email': _emailController.text.toString(),
      }).then((value) {
        print(" user updated is loaded to friestore");
      }).onError(
        (error, stackTrace) {
          print(error.toString());
        },
      );
    }
  }

  void updateUserProfileInformation() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('user').doc(currentUser!.uid).set(
        {
          'name': _nameController.text.toString(),
          'birthday': _birthdayController.text.toString(),
          'bio': _bioController.text.toString(),
          'email': _emailController.text.toString(),
        },
      ).then(
        (value) {
          Utils().ToastMessage(
              "profile successfully updated"); // if update then show it
        },
      ).onError(
        (error, stackTrace) {
          Utils().ToastMessage("Error updating profile"); // on error show this
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // If you only need to fetch the data once (not in real-time),
          //you should use a FutureBuilder instead of a StreamBuilder.
          child: FutureBuilder(
            future: currentUser != null
                ? FirebaseFirestore.instance
                    .collection('user')
                    .doc(currentUser!.uid)
                    .get()
                : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No data found'));
              }
              return Column(children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _birthdayController,
                  decoration: InputDecoration(labelText: 'Birthday'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your birthday';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: 'email'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bioController,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Bio'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your bio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomloginButton(
                  text: 'Save Changes',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      storeUpdateProfileUserData();
                      updateUserProfileInformation();
                    }
                  },
                )
              ]);
            },
          ),
        ),
      ),
    );
  }
}

 // Future<void> _updateUserData() async {
  //   if (_formKey.currentState!.validate()) {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await FirebaseFirestore.instance.collection('user').doc(user.uid).update({
  //         'name': _nameController.text.trim(),
  //         'birthday': _birthdayController.text.trim(),
  //         'bio': _bioController.text.trim(),
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
  //     }
  //   }
  // }