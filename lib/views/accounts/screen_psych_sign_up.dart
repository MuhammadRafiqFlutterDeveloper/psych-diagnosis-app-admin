import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/accounts/screen_psych_sign_in.dart';
import '../../controllers/credential_controller.dart';
import '../constants/colors.dart';

class ScreenPsychSignUp extends StatefulWidget {
  @override
  State<ScreenPsychSignUp> createState() => _ScreenPsychSignUpState();
}

class _ScreenPsychSignUpState extends State<ScreenPsychSignUp> {

  final RegistrationController _controller = Get.put(RegistrationController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _obscureText = true;
  TextEditingController medicalRecord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Signup',
          style: appbarStyle,
        ),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width / 1.10,
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Signup',
              //       style: appbarStyle,
              //     ),
              //   ),
              // ),
              Image.asset(
                'assets/logo/logo.png',
                height: 121,
                width: 135,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Let’s Get It Started!',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    cursorColor: buttonColor,
                    controller: _controller.firstName,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'First Name',
                      hintStyle: textFieldStyle,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First Name Required";
                      } else
                        return null;
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.30,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    cursorColor: buttonColor,
                    controller: _controller.lastname,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Last Name',
                      hintStyle: textFieldStyle,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last Name Required";
                      } else
                        return null;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    cursorColor: buttonColor,
                    controller: _controller.emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Email',
                      hintStyle: textFieldStyle,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email Required";
                      } else
                        return null;
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.30,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    cursorColor: buttonColor,
                    controller: _controller.passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      hintText: 'Password',
                      hintStyle: textFieldStyle,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              obscureText = !obscureText;
                            },
                          );
                        },
                        child: Icon(
                          obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: buttonColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, top: 15, right: 15, bottom: 15),
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    cursorColor: buttonColor,
                    controller: _controller.confirm,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: textFieldStyle,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _obscureText = !_obscureText;
                            },
                          );
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: buttonColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, top: 15, right: 15, bottom: 15),
                      alignLabelWithHint: true,
                      labelStyle:
                          GoogleFonts.getFont('Roboto', color: Colors.blue),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width / 1.30,
                child: MaterialButton(
                  onPressed: ()=>_controller.registerUser(),
                  color: buttonColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "SignUp",
                          style: buttonText,
                        ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          openScreen(context, ScreenPsychLogIn());
                        },
                      text: "Login",
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool isLoading = false;
}



// bool isLoading = false;
//
// var emailController = TextEditingController();
// var passwordController = TextEditingController();
// var confirmPasswordController = TextEditingController();
// var firstNameController = TextEditingController();
// var lastNameController = TextEditingController();
// onPressed: () {
//   if (firstNameController.text.isEmpty) {
//     displayMessage("First Name Required");
//   } else if (lastNameController.text == '') {
//     displayMessage("LastName Required");
//   } else if (emailController.text.isEmpty) {
//     displayMessage("Email required");
//   } else if (passwordController.text.isEmpty) {
//     displayMessage("Password Required");
//   } else if (confirmPasswordController.text.isEmpty) {
//     displayMessage('ConfirmPassword Required');
//   } else if (passwordController.text !=
//       confirmPasswordController.text) {
//     displayMessage("Your Password doesn't Match");
//   } else if (confirmPasswordController.text.length < 6 ||
//       passwordController.text.length < 6) {
//     displayMessage(
//         'password and confirmPassword should be AtLeast 6 Character');
//   } else {
//     openScreen(
//       context,
//       ScreenPsychVerification(
//         fName: firstNameController.text,
//         lName: lastNameController.text,
//         email: emailController.text,
//         password: passwordController.text,
//         confirmPassword: confirmPasswordController.text,
//       ),
//     );
//   }
// },