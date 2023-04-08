import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/main.dart';

import '../constants/colors.dart';
import 'cate_screen.dart';

class AnswerHelp extends StatefulWidget {
  final String name;
  final String email;
  final String image;
  final String userId;

  const AnswerHelp({
    Key? key,
    required this.name,
    required this.email,
    required this.image,
    required this.userId,
  }) : super(key: key);

  @override
  State<AnswerHelp> createState() => _AnswerHelpState();
}

class _AnswerHelpState extends State<AnswerHelp> {
  var issueTitle;
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
          'Help',
          style: appbarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Person Details',
                style: GoogleFonts.getFont(
                  'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                title: Text(
                  '${widget.name}',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${widget.email}',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                trailing: CircleAvatar(
                  backgroundColor: buttonColor,
                  radius: 25,
                  backgroundImage: NetworkImage('${widget.image}'),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Description',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('help').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                // snapshot.data!.docs.forEach(
                //   (document) {
                //     issueTitle = document['issueTitle'];
                //   },
                // );
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            '${snapshot.data!.docs[index]['disc']}',
                            style: GoogleFonts.getFont('Roboto',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.30),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Reply',
                              style: GoogleFonts.getFont('Open Sans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            cursorColor: buttonColor,
                            controller: reply,
                            maxLines: 5,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: buttonColor)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: 'Write reply here...',
                              hintStyle: textFieldStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.30,
                          child: MaterialButton(
                            onPressed: () {
                              if (reply.text.isEmpty) {
                                displayMessage('Enter the Answers');
                              } else {
                                openScreen(
                                    context,
                                    ProviderChatScreen(
                                      issueTitle: snapshot.data?.docs[index]
                                          ['issueTitle'],
                                      reply: reply.text,
                                      userId: widget.userId,
                                      name: widget.name,
                                      email: widget.email,
                                      image: widget.image,
                                    ));
                                displayMessage('Replied Successful');
                              }
                            },
                            // createUser(),
                            color: buttonColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Submit",
                              style: buttonText,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController reply = TextEditingController();
}
