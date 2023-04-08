import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/main.dart';
import 'package:psych_diagnosis_admin/views/screens/screen_major_depresive.dart';
import 'package:uuid/uuid.dart';
import '../constants/colors.dart';

class ScreenDiseases extends StatefulWidget {
  @override
  State<ScreenDiseases> createState() => _ScreenDiseasesState();
}

class _ScreenDiseasesState extends State<ScreenDiseases> {
  bool isloading = false;
  TextEditingController disease = TextEditingController();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0";
  }

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
        centerTitle: true,
        title: Text(
          'Diseases',
          style: appbarStyle,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('disease')
              .where('admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Data Doesn't Exist"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            } else {}
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
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data?.docs[index];
                      var uid = snapshot.data?.docs[index]['uid'];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              onTap: () {
                                openScreen(
                                  context,
                                  ScreenMajorDepressive(
                                      uid: '${data?['uid']}',
                                      text: '${data?['disease']} '),
                                );
                              },
                              title: RichText(
                                text: TextSpan(
                                  text: '${data?['disease']}',
                                  style: questionStyle,
                                  children: [
                                    TextSpan(
                                      text: '(${data?['mini']})',
                                      //             maxLines: 2,
                                      style: questionStyle,
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10,),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Center(
                                                child: Text(
                                                  'Edit Disease',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: buttonColor,
                                                  ),
                                                ),
                                              ),
                                              children: [
                                                Container(
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      'Title',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Container(
                                                  height: 55,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: TextField(
                                                    cursorColor: buttonColor,
                                                    controller: disease
                                                      ..text = data?['disease'],
                                                    decoration: InputDecoration(
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                          borderSide:
                                                          BorderSide(
                                                            color: buttonColor,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      'Minimum yes',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                                Container(
                                                  height: 55,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: TextField(
                                                    cursorColor: buttonColor,
                                                    decoration: InputDecoration(
                                                      border:
                                                      OutlineInputBorder(),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: buttonColor,
                                                        ),
                                                      ),
                                                      contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      suffixIcon: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          GestureDetector(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_up_outlined,
                                                              color:
                                                              Colors.black,
                                                            ),
                                                            onTap: () {
                                                              int currentValue =
                                                              int.parse(
                                                                  _controller
                                                                      .text);
                                                              setState(() {
                                                                currentValue--;
                                                                _controller
                                                                    .text =
                                                                    currentValue
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              int currentValue =
                                                              int.parse(
                                                                  _controller
                                                                      .text);
                                                              setState(() {
                                                                currentValue++;
                                                                _controller
                                                                    .text =
                                                                    currentValue
                                                                        .toString();
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color:
                                                              Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    controller: _controller
                                                      ..text = data?['mini'],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                      decimal: false,
                                                      signed: true,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 43,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: BorderSide(
                                                        color: buttonColor,
                                                      ),
                                                      backgroundColor:
                                                      buttonColor,
                                                      elevation: 4,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10)),
                                                    ),
                                                    onPressed: () {
                                                      try {
                                                        setState(() {
                                                          isloading = true;
                                                        });
                                                        if (disease
                                                            .text.isEmpty) {
                                                          displayMessage(
                                                              'Please Enter the Disease Name');
                                                        } else if (_controller
                                                            .text.isEmpty) {
                                                          displayMessage(
                                                              'Enter the Minimum Yes');
                                                        } else {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              'disease')
                                                              .doc(uid)
                                                              .update({
                                                            'disease': disease
                                                                .text
                                                                .trim(),
                                                            'mini': _controller
                                                                .text
                                                                .trim(),
                                                          }).then((value) {
                                                            Navigator.pop(
                                                                context);
                                                          }).whenComplete(() {
                                                            displayMessage(
                                                                'Disease update Successfully');
                                                          });
                                                        }
                                                        setState(() {
                                                          isloading = false;
                                                        });
                                                      } catch (error) {
                                                        displayMessage(
                                                            error.toString());
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
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      FirebaseFirestore.instance
                                          .collection('disease')
                                          .doc(uid)
                                          .delete()
                                          .whenComplete(
                                            () {
                                          displayMessage(
                                              'Disease Successfully');
                                        },
                                      );
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
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            )
                          ],
                        ),
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
              return MyDialog();
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
  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  bool isloading = false;
  TextEditingController disease = TextEditingController();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0";
  }

  var uid = Uuid().v1();
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        textAlign: TextAlign.center,
        'Add New Disease',
        style: GoogleFonts.getFont(
          'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: buttonColor,
        ),
      ),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Title",
              style: GoogleFonts.getFont(
                'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 63,
            width: MediaQuery.of(context).size.width / 1.30,
            child: TextFormField(
              cursorColor: buttonColor,
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
          height: 15,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Minimum yes",
              style: GoogleFonts.getFont(
                'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 62,
            width: MediaQuery.of(context).size.width / 1.30,
            child: TextFormField(
              cursorColor: buttonColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: buttonColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                suffixIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_drop_up_outlined,
                        color: Colors.black,
                      ),
                      onTap: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          currentValue--;
                          _controller.text = currentValue.toString();
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        int currentValue = int.parse(_controller.text);
                        setState(() {
                          currentValue++;
                          _controller.text = currentValue.toString();
                        });
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
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
                  } else if (_controller.text.isEmpty) {
                    displayMessage('Enter the Minimum Yes');
                  } else {
                    var _auth = FirebaseAuth.instance;
                    final User? user = _auth.currentUser;
                    final _uid = user!.uid;
                    FirebaseFirestore.instance
                        .collection('disease')
                        .doc(uid)
                        .set({
                      'date': DateTime.now(),
                      'uid': uid,
                      'admin': _uid,
                      'disease': disease.text.trim(),
                      'mini': _controller.text.trim(),
                    }).whenComplete(() {
                      displayMessage('Disease Added Successfully');
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
}
