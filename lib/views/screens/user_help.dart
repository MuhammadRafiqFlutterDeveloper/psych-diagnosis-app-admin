import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psych_diagnosis_admin/views/screens/answer_help.dart';
import '../constants/colors.dart';

class UserHelp extends StatefulWidget {
  @override
  State<UserHelp> createState() => _UserHelpState();
}

class _UserHelpState extends State<UserHelp> {
  final TextEditingController searchController = TextEditingController();
  bool searchState = false;
  List searchResult = [];
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: searchState
            ? Text(
                'Help',
                style: appbarStyle,
              )
            : Container(
                height: 50,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search.....', hintStyle: textFieldStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    // labelText: 'Search places...',
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search_outlined,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
        actions: [
          searchState
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: buttonColor,
                  ),
                ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('help')
            .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "An error occurred",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(
              child: Text('No User Found'),
            );
          }

          var userId = snapshot.data.docs[0]['userId'];
          return StreamBuilder(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection('users')
                    .where("firstName", isGreaterThanOrEqualTo: name)
                    .where('uid',
                        isEqualTo: userId)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('users')
                    .where('uid',
                        isEqualTo: userId)
                    .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                Center(
                  child: Text('user not Found'),
                );
              }
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: Text(
                        'User not Found',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data!.docs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: buttonColor,
                            radius: 30,
                            backgroundImage: NetworkImage('${data['profile']}'),
                          ),
                          title: Text(
                            '${data['firstName']} ${data['lastName']}',
                            style: appbarStyle,
                          ),
                          subtitle: Text(
                            '${data['email']}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.76),
                            ),
                          ),
                          onTap: () {
                            openScreen(
                              context,
                              AnswerHelp(
                                name: data['firstName'] + data['lastName'],
                                email: data['email'],
                                userId: data['uid'],
                                image: data['profile'],
                              ),
                            );
                          },
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        );
                      },
                    );
            },
          );
        },
      ),
    );
  }

  int totalQuestion = 0;
  List<String> userIdList = [];
  StreamSubscription<QuerySnapshot>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = FirebaseFirestore.instance
        .collection('user_answers')
        .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        totalQuestion = snapshot.docs.length;
        for (var doc in snapshot.docs) {
          userIdList.add(doc.data()['userId']);
        }
        print("User IDs: $userIdList");
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
