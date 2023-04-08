import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/colors.dart';

class ScreenPsychForgotPassword extends StatefulWidget {
  @override
  State<ScreenPsychForgotPassword> createState() =>
      _ScreenPsychForgotPasswordState();
}

class _ScreenPsychForgotPasswordState extends State<ScreenPsychForgotPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password',
                    style: appbarStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width / 1.30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your email to recover your password ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                    controller: emailCont,
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width / 1.30,
                child: MaterialButton(
                  onPressed: () => forgotPassword(),
                  color: buttonColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : Text(
                          'Send',
                          style: buttonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var emailCont = TextEditingController();

  Future<void> forgotPassword() async {
    try{
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailCont.text)
          .then((value) {

        displayMessage(
            "Reset email was sent Please check your Email reset your Password");
      });
      setState(() {
        _isLoading = false;
      });
    }catch(error){
      displayMessage(error.toString());
    }
  }
}
