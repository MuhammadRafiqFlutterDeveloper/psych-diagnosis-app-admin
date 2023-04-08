import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';
import 'package:psych_diagnosis_admin/views/screens/screen_diseases.dart';
import 'package:psych_diagnosis_admin/views/screens/screen_users.dart';
import 'package:psych_diagnosis_admin/views/screens/user_help.dart';
import '../porfile/profile_psych_profile.dart';

class ScreenDashboard extends StatefulWidget {

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'currantDate': DateTime.now(),
    });

  }

  @override
  void initState() {
    setState(() {
      getUserData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: buttonText,
        ),
        elevation: 0,
        backgroundColor: buttonColor,
        leading: Image.asset(
          'assets/logo/menu1.png',
          height: 5,
          width: 5,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              color: buttonColor,
              height: 70,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 145,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.40),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            openScreen(context, ScreenUsers());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/logo/people.png',
                                height: 45,
                                width: 45,
                              ),
                              Text(
                                'Users',
                                style: appbarStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.40),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            openScreen(context, ScreenDiseases());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/logo/category.png',
                                height: 45,
                                width: 45,
                              ),
                              Text(
                                'Diseases',
                                style: appbarStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 145,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.40),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            openScreen(context, ProfilePsychProfile());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/logo/profile1.png',
                                height: 45,
                                width: 45,
                              ),
                              Text(
                                'Profile',
                                style: appbarStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.40),
                              blurRadius: 5,
                              spreadRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            openScreen(context, UserHelp());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.help_outline,
                                size: 45,
                                color: buttonColor,
                              ),
                              Text(
                                'Help',
                                style: appbarStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
