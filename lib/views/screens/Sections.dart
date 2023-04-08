import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../layout_sections.dart';

int totalQuestion = 0;

class ScreenPsychSection1 extends StatefulWidget {
  final String diseaseId;
  final String adminId;
  final sectionCount;

  const ScreenPsychSection1({
    required this.diseaseId,
    required this.adminId,
    required this.sectionCount,
  });

  @override
  State<ScreenPsychSection1> createState() => _ScreenPsychSection1State();
}

class _ScreenPsychSection1State extends State<ScreenPsychSection1> {
  @override
  void initState() {
    totalQuestion = 0;
    super.initState();
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
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
          'Section ${widget.sectionCount}',
          style: appbarStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user_answers')
                  .where('diseaseId', isEqualTo: widget.diseaseId)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Question Answers Doesn't Exist"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: buttonColor,
                    ),
                  );
                }
                totalQuestion = snapshot.data!.docs.length;
                return snapshot.data?.size == 0
                    ? Center(
                        child: Text("Question Answers Doesn't Exist"),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return LayoutPsychSection(
                            question: snapshot.data?.docs[index]['question'],
                            answer: snapshot.data?.docs[index]['answer'],
                          );
                        },
                      );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
