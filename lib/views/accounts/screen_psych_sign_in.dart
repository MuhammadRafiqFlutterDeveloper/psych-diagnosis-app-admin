import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:psych_diagnosis_admin/views/accounts/screen_pshch_forgot_password.dart';
import 'package:psych_diagnosis_admin/views/accounts/screen_psych_sign_up.dart';
import '../../main.dart';
import '../constants/colors.dart';
import '../screens/screen_dashboard.dart';

class ScreenPsychLogIn extends StatefulWidget {
  @override
  State<ScreenPsychLogIn> createState() => _ScreenPsychLogInState();
}

class _ScreenPsychLogInState extends State<ScreenPsychLogIn> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _obscureText = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLoading = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Login',
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
                //   height: 30,
                // ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 1.10,
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'Login',
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
                    'Welcome back!',
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
                      controller: emailController,
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
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Email Required";
                      //   } else
                      //     return null;
                      // },
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
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
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
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: 'Password',
                        hintStyle: textFieldStyle,
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        openScreen(context, ScreenPsychForgotPassword());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 43,
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: MaterialButton(
                    onPressed: () => loginUser(),
                    color: buttonColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: _isLoading
                        ? Container(
                            height: 27,
                            width: 27,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Text(
                            "Login",
                            style: buttonText,
                          ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/logo/img_12.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                SizedBox(
                  height: 20,
                ),
                Loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: buttonColor,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => handleSignIn(context),
                        child: Image.asset(
                          'assets/logo/img_9.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                SizedBox(height: 30,),
                RichText(
                  text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openScreen(context, ScreenPsychSignUp());
                            },
                          text: "SignUp",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: buttonColor,
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loginUser() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        displayMessage('Please enter Email and Password');
      } else {
        // logging in user with email and password
        setState(() {
          _isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        setState(() {
          _isLoading = false;
        });
        displayMessage('Login Success');
        openScreen(context, ScreenDashboard());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (e.code == 'user-not-found') {
        displayMessage('No Record Found.');
      } else if (e.code == 'wrong-password') {
        displayMessage('Wrong password provided for that user.');
      } else {
        displayMessage('Login failed. Please try again.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      displayMessage('Login failed. Please try again.');
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    // Attempt to sign in the user with their Google account.
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User cancelled the sign-in flow.
      return null;
    }

    // Authenticate with Firebase using the GoogleSignInAuthentication data.
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential.
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential.user;
  }

  Future<void> addUserToFirestore(User user) async {
    // Split the user's display name into first name and last name.
    final List<String> nameParts = user.displayName!.split(' ');
    String firstName = nameParts.first;
    String lastName = nameParts.length > 1 ? nameParts.last : '';

    // Add the user to Firestore.
    final userDoc =
        FirebaseFirestore.instance.collection('admin').doc(user.uid);
    await userDoc.set({
      'adminId': user.uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': user.email,
      'password': '',
      'confirm': '',
      'education':'',
      'currantDate': Timestamp.now(),
      'birth': '',
      'race': '',
      'sex': '',
      'status': '',
      'about': '',
      'availability': false,
      'profile': user.photoURL,
    });
  }

  Future<void> handleSignIn(BuildContext context) async {
    try {
      setState(() {
        Loading = true;
      });
      // Sign in with Google and get the user data.
      final User? user = await signInWithGoogle();
      if (user == null) {
        // User cancelled the sign-in flow.
        return;
      }

      // Add the user data to Firestore.
      await addUserToFirestore(user);

      // Navigate to the home screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ScreenDashboard()),
      );
      setState(() {
        Loading = false;
      });
    } catch (e) {
      // Handle sign-in errors.
      print('Error signing in with Google: $e');
    }
  }

  bool Loading = false;
}
