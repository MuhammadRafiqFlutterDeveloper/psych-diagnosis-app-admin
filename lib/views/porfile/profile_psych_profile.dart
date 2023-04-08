import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/porfile/profile_psych_about.dart';
import 'package:psych_diagnosis_admin/views/porfile/profile_psych_change_password.dart';
import 'package:psych_diagnosis_admin/views/porfile/profile_psych_edit_account.dart';
import 'package:psych_diagnosis_admin/views/porfile/profile_psych_help.dart';
import '../accounts/screen_psych_sign_in.dart';
import '../constants/colors.dart';

class ProfilePsychProfile extends StatefulWidget {
  @override
  State<ProfilePsychProfile> createState() => _ProfilePsychProfileState();
}

class _ProfilePsychProfileState extends State<ProfilePsychProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: buttonColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Profile Setting',
          style: buttonText,
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('admin')
            .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            color: buttonColor,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(250),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 20,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]['profile'],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '${snapshot.data!.docs[index]['firstName'] + ' ' + snapshot.data!.docs[index]['lastName']}',
                                style: appbarStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '${snapshot.data!.docs[index]['email']}',
                                style: questionStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        // margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffC4C4C4).withOpacity(0.33),
                        ),
                        child: Text(
                          '   Preferences',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff7B8471),
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.02,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 1,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logo/img_2.png',
                            height: 36,
                            width: 36,
                          ),
                          title: Text(
                            "Edit Account",
                            style: questionStyle,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          onTap: () {
                            openScreen(
                              context,
                              ProfilePsychEditAccount(
                                      profile: snapshot.data?.docs[index]['profile'],
                                      firstName: snapshot.data?.docs[index]['firstName'],
                                      lastName: snapshot.data?.docs[index]['lastName'],
                                      email: snapshot.data?.docs[index]['email'],
                                      material: snapshot.data?.docs[index]['status'],
                                      sex: snapshot.data?.docs[index]['sex'],
                                      birth: snapshot.data?.docs[index]['birth'],
                                      race: snapshot.data?.docs[index]['race'],
                                  about: snapshot.data?.docs[index]['about'],
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.02,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 1,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logo/img_1.png',
                            height: 36,
                            width: 36,
                          ),
                          title: Text(
                            "Help",
                            style: questionStyle,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          onTap: () {
                            openScreen(context, ProfilePsychHelp());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.02,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 1,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logo/img_3.png',
                            height: 36,
                            width: 36,
                          ),
                          title: Text(
                            "Change Password",
                            style: questionStyle,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          onTap: () {
                            openScreen(context, ProfilePsychChangePassword());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.02,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 1,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logo/img_4.png',
                            height: 36,
                            width: 36,
                          ),
                          title: Text(
                            "About",
                            style: questionStyle,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          onTap: () {
                            openScreen(context, ProfilePsychAbout());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.02,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 1,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/logo/img_5.png',
                            height: 36,
                            width: 36,
                          ),
                          title: Text(
                            "Logout",
                            style: questionStyle,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext? context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context!);
                                            },
                                            icon: Image.asset(
                                              'assets/logo/img_6.png',
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Image.asset(
                                        'assets/logo/Logout.png',
                                        height: 55,
                                        width: 55,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                        'Are you sure you want to Logout?',
                                        style: questionStyle,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context!).size.width /
                                                1.30,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            final FirebaseAuth _auth =
                                                FirebaseAuth.instance;
                                            await _auth
                                                .signOut()
                                                .whenComplete(() {
                                              openScreen(
                                                  context, ScreenPsychLogIn());
                                            });
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                          color: buttonColor,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: _isLoading
                                              ? CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                )
                                              : Text(
                                                  'Logout now',
                                                  style: buttonText,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool _isLoading = false;
}
