import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/screens/Sections.dart';

import 'constants/colors.dart';

class LayoutPsychHome extends StatefulWidget {
  final String disease;
  final minimumYes;
  final String diseaseId;
  final String adminId;
  final int sectionCount;
  const LayoutPsychHome({
    Key? key,
    required this.disease,
    required this.minimumYes,
    required this.diseaseId,
    required this.adminId,
    required this.sectionCount,
  }) : super(key: key);

  @override
  State<LayoutPsychHome> createState() => _LayoutPsychHomeState();
}

class _LayoutPsychHomeState extends State<LayoutPsychHome> {
  int totalYes = 0;
  int totalNo = 0;
  Widget _calculateIcon(int totalAnswer, int totalYes, int totalNo) {
    if (totalAnswer == 0 || (totalYes == 0 && totalNo == 0)) {
      return Container();
    } else if (totalNo > totalYes) {
      return Image.asset(
        'assets/logo/img_16.png',
        height: 15,
        width: 15,
      );
    } else {
      return Container(
        height: 15,
        width: 15,
        child: Image.asset(
          'assets/logo/img_17.png',
          height: 15,
          width: 15,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.02,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 1,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user_answers')
              .where('adminId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('diseaseId', isEqualTo: widget.diseaseId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(
                  backgroundColor: buttonColor,
                ),
              );
            }
            totalYes = 0;
            totalNo = 0;
            // int totalAnswer = snapshot.data!.docs.length;
            for (var document in snapshot.data!.docs) {
              String answer = document.get('answer') as String;
              if (answer == 'Yes') {
                totalYes++;
                print("Yes $totalYes");
              } else if (answer == 'No') {
                totalNo++;
                print("No $totalNo");
              }
            }
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: 'Section ${widget.sectionCount}',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' ($totalAnswer questions)',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA5A5A5),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                openScreen(
                  context,
                  ScreenPsychSection1(
                    sectionCount: widget.sectionCount,
                    diseaseId: widget.diseaseId,
                    adminId: widget.adminId,
                  ),
                );
              },
              trailing: Container(
                width: 50,
                height: 50,
                child: _calculateIcon(totalAnswer, totalYes, totalNo),
              ),
            );
          },
        ),
      ),
    );
  }

  int totalAnswer = 0;
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FirebaseFirestore.instance
        .collection('user_answers')
        .where('diseaseId', isEqualTo: widget.diseaseId)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        totalAnswer = snapshot.docs.length;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
