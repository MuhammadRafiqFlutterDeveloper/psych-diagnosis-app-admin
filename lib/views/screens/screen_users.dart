import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';
import 'package:psych_diagnosis_admin/views/screens/user_detail.dart';

class ScreenUsers extends StatefulWidget {
  @override
  State<ScreenUsers> createState() => _ScreenUsersState();
}

class _ScreenUsersState extends State<ScreenUsers> {
  final TextEditingController searchController = TextEditingController();
  bool searchState = false;
  List searchResult = [];
  String name = "";

  // var userId;

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
        title: searchState
            ? Container(
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
              )
            : Text(
                'Users',
                style: appbarStyle,
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
                    Icons.cancel_outlined,
                    color: buttonColor,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_answers')
            .where('adminId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          return StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: userId)
                    .where("firstName", isGreaterThanOrEqualTo: name)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: userId)
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No User Found",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: buttonColor,
                          radius: 25,
                          backgroundImage: NetworkImage(data['profile']),
                        ),
                        title: Text(
                          data['firstName']+' ' + data['lastName'],
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          data['email'],
                          style: GoogleFonts.getFont(
                            'Open Sans',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.76),
                          ),
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            openScreen(
                                context,
                                UserDetail(
                                  name: data['firstName'] + data['lastName'],
                                  email: data['email'],
                                  profile: data['profile'],
                                  about: data['about'],
                                  race: data['race'],
                                  sex: data['sex'],
                                  status: data['status'],
                                  birth: data['birth'],
                                  useId: data['uid'],
                                    availability: data['availability'],
                                ));
                          },
                          child: Image.asset('assets/logo/img_10.png'),
                        ),
                      ),
                      Divider(
                        color: Color(0xffA5A5A5),
                        indent: 0.5,
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
  // @override
  // void initState() {
  //   UserData().getData();
  //   print("fix is $userId");
  //
  //   // TODO: implement initState
  //   super.initState();
  // }
}

// String userId = '';
//
// class UserData {
//   getData() async {
//     final DocumentSnapshot userDic = await FirebaseFirestore.instance
//         .collection('user_answers')
//         .doc()
//         .get();
//     userId = userDic.get('userId');
//     print("print  $userId");
//   }
// }

