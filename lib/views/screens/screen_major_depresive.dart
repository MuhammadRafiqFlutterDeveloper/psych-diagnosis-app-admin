import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../main.dart';
import '../constants/colors.dart';

class ScreenMajorDepressive extends StatefulWidget {
  final String text;
  final String uid;
  const ScreenMajorDepressive({Key? key, required this.text, required this.uid})
      : super(key: key);

  @override
  State<ScreenMajorDepressive> createState() => _ScreenMajorDepressiveState();
}

class _ScreenMajorDepressiveState extends State<ScreenMajorDepressive> {

  bool isloading = false;
  TextEditingController questionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.text}',
            style: appbarStyle,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('question')
              .where('diseaseId', isEqualTo: widget.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Question Doesn't Exist"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            } else {}
            return snapshot.data?.size == 0 ? Center(
              child: Text('No data Found', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black,),),
            ):
              ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data!.docs[index];
                var _uid = snapshot.data!.docs[index]['questionId'];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        maxLines: 4,
                        '${data['question']}',
                        style: questionStyle,
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: Text(
                                      textAlign: TextAlign.center,
                                      'Add New Question',
                                      style: GoogleFonts.getFont(
                                        'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor,
                                      ),
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.30,
                                          child: TextFormField(
                                            cursorColor: buttonColor,
                                            maxLines: 8,
                                            controller: questionController..text = data['question'],
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              hintText: 'Disease name',
                                              hintStyle: textFieldStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                        child: SizedBox(
                                          height: 43,
                                          width: MediaQuery.of(context).size.width / 1.30,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                color: buttonColor,
                                              ),
                                              backgroundColor: buttonColor,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                            ),
                                            onPressed: () {
                                              try {
                                                setState(() {
                                                  isloading = true;
                                                });
                                                if (questionController.text.isEmpty) {
                                                  displayMessage('Please Enter the question');
                                                } else {
                                                  FirebaseFirestore.instance
                                                      .collection('question')
                                                      .doc(_uid)
                                                      .update({
                                                    'question': questionController.text.toString().trim(),
                                                  }).whenComplete(() {
                                                    displayMessage('Disease update Successfully');
                                                    Navigator.pop(context);
                                                  });
                                                }
                                                setState(() {
                                                  isloading = false;
                                                });
                                              } catch (error) {
                                                displayMessage(error.toString());
                                              }
                                            },
                                            child: isloading
                                                ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                                : Text(
                                              'Request Publish',
                                              style: buttonText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.edit,
                              color: buttonColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('question')
                                  .doc(_uid)
                                  .delete()
                                  .whenComplete(() {
                                displayMessage(
                                    'Question Delete Successfully');
                                Navigator.pop(context);
                              });
                            },
                            child: Icon(
                              Icons.delete_forever_outlined,
                              color: buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialog(
                uid: widget.uid,
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  final String uid;

  const MyDialog({super.key, required this.uid});
  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  TextEditingController disease = TextEditingController();
  var _uid = Uuid().v1();
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        textAlign: TextAlign.center,
        'Add New Question',
        style: GoogleFonts.getFont(
          'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: buttonColor,
        ),
      ),
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.30,
            child: TextFormField(
              cursorColor: buttonColor,
              maxLines: 8,
              controller: disease,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: buttonColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: 'Disease name',
                hintStyle: textFieldStyle,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 43,
            width: MediaQuery.of(context).size.width / 1.30,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: buttonColor,
                ),
                backgroundColor: buttonColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                try {
                  setState(() {
                    isloading = true;
                  });
                  if (disease.text.isEmpty) {
                    displayMessage('Please Enter the Disease Name');
                  } else {
                    FirebaseFirestore.instance
                        .collection('question')
                        .doc(_uid)
                        .set({
                      'questionId': _uid,
                      'diseaseId': widget.uid,
                      'status': '',
                      "doctorid": FirebaseAuth.instance.currentUser!.uid,
                      'question': disease.text.trim(),
                    }).whenComplete(() {
                      displayMessage('Question Added Successfully');
                      Navigator.pop(context);
                    });
                  }
                  setState(() {
                    isloading = false;
                  });
                } catch (error) {
                  displayMessage(error.toString());
                }
              },
              child: isloading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Request Publish',
                      style: buttonText,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  bool isloading = false;
}
