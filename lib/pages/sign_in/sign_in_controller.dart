import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

import '../../common/apis/user_api.dart';
import '../global.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        // or BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String email = state.email;
        String password = state.password;
        if (email.isEmpty) {
          toastInfo(msg: "Email is empty");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Password is empty");
          return;
        }
        // Network issues
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          if (credential.user == null) {
            toastInfo(msg: "User does not exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "Verify the account first");
            return;
          }

          var user = credential.user;
          if (user != null) {
            // the user is verified
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            print('my url is $photoUrl');

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.openId = id;
            // Type 1 = email login
            loginRequestEntity.type = 1;

            print('user exist');

            asyncPostAllData(loginRequestEntity);
            // Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
            // Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
          } else {
            // error getting user
            toastInfo(msg: "No user for this app");
            return;
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('no user found for this email');
            toastInfo(msg: "No user for this email");
          } else if (e.code == 'wrong-password') {
            print('wrong password for this user');
            toastInfo(msg: "Wrong password for this user");
          } else if (e.code == 'invalid-email') {
            print('your email format is wrong');
            toastInfo(msg: "Your email format is wrong");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(params: loginRequestEntity);
    // print(result.data?.toJson());

    if (result.code == 200) {
      try {
        Global.storageService
            .setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
        Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.accessToken!);
        EasyLoading.dismiss();
        Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
      } catch (e) {
        print("saving local storage error ${e.toString()}");
      }
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: "Unknown error (${result.code})");
    }
  }
}
