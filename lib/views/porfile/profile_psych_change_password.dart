import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/colors.dart';

class ProfilePsychChangePassword extends StatefulWidget {
  @override
  State<ProfilePsychChangePassword> createState() =>
      _ProfilePsychChangePasswordState();
}

class _ProfilePsychChangePasswordState
    extends State<ProfilePsychChangePassword> {
  bool _isHidden = true;
  bool isHidden = true;
  bool hidden = true;
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmNew = TextEditingController();
  Future<void> changePassword() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = await _auth.currentUser;
    if (user == null) {
      // Handle user not signed in
      displayMessage('user not signed in');
      return;
    }
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email ?? '',
      password: oldPassword.text,
    );
    try {
      setState(() {
        _isLoading = true;
      });
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword.text);
      displayMessage('Password Update Successfully');
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      displayMessage(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Change Password',
          style: appbarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/logo/logo.png',
                height: 121,
                width: 135,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: oldPassword,
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    hintText: 'Old Password',
                    hintStyle: textFieldStyle,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      child: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                        color: buttonColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 15),
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: newPassword,
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    hintText: 'New Password',
                    hintStyle: textFieldStyle,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: buttonColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 15),
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: MediaQuery.of(context).size.width / 1.30,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: confirmNew,
                  obscureText: hidden,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    hintText: 'Confirm New Password',
                    hintStyle: textFieldStyle,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      child: Icon(
                        hidden ? Icons.visibility_off : Icons.visibility,
                        color: buttonColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 15, top: 15, right: 15, bottom: 15),
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width / 1.30,
                child: MaterialButton(
                  onPressed: () => changePassword(),
                  color: buttonColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Change Password',
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

  bool _isLoading = false;
}
