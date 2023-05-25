import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psych_diagnosis_admin/views/accounts/accounts_psych_complete_profile.dart';
import '../main.dart';
import '../models/get_data.dart';
import '../models/user_model.dart' as model;
import '../views/accounts/screen_pshch_verification.dart';

class RegistrationController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirm = TextEditingController();
  var dobController = TextEditingController();
  var imageIndex = 0;
  var selectedDateTime = 0;

  var firstName = TextEditingController();
  var lastname = TextEditingController();

  late UserProvider _userProvider;

  @override
  void onInit() {
    super.onInit();
    _userProvider = Get.find<UserProvider>();
  }

  model.User? get user => _userProvider.user;

  void setUser(User user) {
    _userProvider.setUser(user as model.User);
  }

  void loginUser() {
    String email = emailController.text;
    String password = passwordController.text;

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (value.user!.emailVerified) {
        // Get.to(ScreenUserLocation());
      } else {
        Get.defaultDialog(
            title: "Email not verified",
            content: Text("Please check and verify your email."),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    value.user!.sendEmailVerification();
                    Get.back();
                  },
                  child: Text("Resend email")),
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Dismiss")),
            ]);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void registerUser() async {
    if (firstName.text.isEmpty) {
      displayMessage("First Name Required");
    } else if (lastname.text == '') {
      displayMessage("LastName Required");
    } else if (emailController.text.isEmpty) {
      displayMessage("Email required");
    } else if (passwordController.text.isEmpty) {
      displayMessage("Password Required");
    } else if (confirm.text.isEmpty) {
      displayMessage('ConfirmPassword Required');
    } else if (passwordController.text != confirm.text) {
      displayMessage("Your Password doesn't Match");
    } else if (confirm.text.length < 6 || passwordController.text.length < 6) {
      displayMessage(
          'password and confirmPassword should be AtLeast 6 Character');
    } else {
      Get.to(
        ScreenPsychVerification(
          email: emailController.text,
          fName: firstName.text,
          lName: lastname.text,
        ),
      );
    }

    // print(result);
  }

  void Register() async {
    String myEmail = emailController.text;
    String password = passwordController.text;
    String confirmP = confirm.text;
    String fName = firstName.text;
    String lName = lastname.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: myEmail, password: password);

      var uid = userCredential.user!.uid;

      var user = model.User(
        uid: uid,
        firstName: fName,
        race: "",
        about: "",
        currentDate: DateTime.now().toString(),
        sex: "",
        status: "",
        lastName: lName,
        password: password,
        confirm: confirmP,
        email: myEmail,
        lastSeen: DateTime.now().millisecondsSinceEpoch.toString(),
        notificationToken: "",
        birth: selectedDateTime.toString(),
        profile: imageIndex.toString(),
      );

      await FirebaseFirestore.instance
          .collection("admin")
          .doc(uid)
          .set(user.toMap())
          .then((value) {
        Get.to(ScreenPsychCompleteProfile(uid: uid));
      });
      displayMessage("User registered successfully");
      print("DB stored");
    } catch (error) {
      if (error is FirebaseAuthException) {
        String errorMessage = error.message ?? 'An error occurred';
        displayMessage(errorMessage);
      } else {
        displayMessage("An error occurred");
      }
    }
  }

  void forgotPassword() {
    var email = emailController.text;
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      displayMessage("Reset email sent");
    }).catchError((error) {
      displayMessage(error);
    });
  }
}
