import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/register/bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});

  void handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.username;
    String email = state.email;
    String password = state.password;
    String confirmPassword = state.confirmPassword;

    if (userName.isEmpty) {
      toastInfo(msg: "Username cannot be empty");
    }

    if (email.isEmpty) {
      toastInfo(msg: "Email cannot be empty");
    }

    if (password.isEmpty) {
      toastInfo(msg: "Password cannot be empty");
    }

    if (confirmPassword.isEmpty) {
      toastInfo(msg: "Password confirmation is wrong");
    }

    try {
      // try to register an account
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // sending verification email via firebase
      if (credential.user != null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(userName);
        String photoUrl = "uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);
        toastInfo(msg: "An email verification has been sent. Please check your email");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toastInfo(msg: "The password is weak");
      } else if (e.code == 'email-already-in-use') {
        toastInfo(msg: "Email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "Email format is invalid");
      }
    }
  }
}
