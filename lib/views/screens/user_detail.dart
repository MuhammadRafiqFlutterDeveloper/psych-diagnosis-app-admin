import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';

import '../layouts_home.dart';

class UserDetail extends StatefulWidget {
  final name;
  final profile;
  final email;
  final race;
  final birth;
  final sex;
  final status;
  final about;
  final useId;
  final availability;

  const UserDetail(
      {Key? key,
      this.name,
      this.profile,
      this.email,
      this.race,
      this.birth,
      this.sex,
      this.status,
      this.about,
      this.useId,
      this.availability})
      : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  bool _availability = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'User Details',
          style: appbarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: buttonColor.withOpacity(0.10),
                backgroundImage: NetworkImage(widget.profile),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.name,
                style: appbarStyle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(20),
              child: Text(
                'Info',
                style: appbarStyle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: color,
                    size: 16,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: color,
              height: 0.5,
              endIndent: 30,
              indent: 30,
            ),
            Container(
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/img_11.png',
                              color: color,
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.sex,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 0.5,
                          color: color,
                          endIndent: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/img_13.png',
                              color: color,
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.status,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 0.5,
                          color: color,
                          endIndent: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/img_14.png',
                              color: color,
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.birth,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 0.5,
                          color: color,
                          endIndent: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/img_15.png',
                              color: color,
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.race,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 0.5,
                          color: color,
                          endIndent: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.about,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 43,
                width: MediaQuery.of(context).size.width / 2.4,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffFF031B),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Blocked User',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Are you sure you want to Block this User?',
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xffD4D4D4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.getFont(
                                          'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Color(0xffFF031B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          _availability = !_availability;
                                        });
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(widget.useId)
                                            .update({
                                          'availability': true,
                                        });
                                        print('User blocked successfully');
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        // _availability
                                        //     ? 'Unblock'
                                        //     :
                                        'Block',
                                        style: GoogleFonts.getFont(
                                          'Roboto',
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        // widget.availability == false
                        //     ? 'active'
                        //     :
                        'Block User',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color:
                              // widget.availability == true
                              //     ? Color(0xffFF031B)
                              //     :
                              Color(0xffFF031B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Attempted Sections',
                style: appbarStyle,
              ),
            ),
            Container(
              height: 300,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('disease')
                    .where('admin',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Data doesn't Exist"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: buttonColor,
                      ),
                    );
                  }
                  return snapshot.data?.size == 0
                      ? Center(
                          child: Text(
                            'No data Found',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final sectionCount = index + 1;
                            return LayoutPsychHome(
                              disease: snapshot.data?.docs[index]['disease'],
                              minimumYes: snapshot.data?.docs[index]['mini'],
                              diseaseId: snapshot.data?.docs[index]['uid'],
                              adminId: snapshot.data?.docs[index]['admin'],
                              sectionCount: sectionCount,
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var color = Color(0xff030229);
