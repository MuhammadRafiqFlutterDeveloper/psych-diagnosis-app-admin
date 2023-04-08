import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/colors.dart';


class ProfilePsychHelp extends StatefulWidget {
  @override
  State<ProfilePsychHelp> createState() => _ProfilePsychHelpState();
}

class _ProfilePsychHelpState extends State<ProfilePsychHelp> {
  var nameController = TextEditingController();

  var emailComtroller = TextEditingController();

  var feedController = TextEditingController();

  Future<void> help() async {
    setState(() {
      loading = true;
    });
    if (nameController.text.isEmpty) {
      displayMessage('Please Enter Your name');
    } else if (emailComtroller.text.isEmpty) {
      displayMessage('Please Enter Your email');
    } else if (feedController.text.isEmpty) {
      displayMessage('Please Enter Your Feedback');
    } else {
      CollectionReference products =
          FirebaseFirestore.instance.collection('help');
      products.doc().set({
        'name': nameController.text,
        'email': emailComtroller.text,
        'feed': feedController.text,
      }).whenComplete(() {
        displayMessage('FeedBack Successfully Sent');
      });
      return print('hello');
    }
    setState(() {
      loading = false;
    });
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Help",
          style: button,
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 1.97,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)]),
              child: Column(
                children: [
                  Container(
                    height: 43,
                    width: MediaQuery.of(context).size.width * 0.90,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      cursorColor: buttonColor,
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Your Name",
                        hintStyle: text,
                      ),
                    ),
                  ),
                  Container(
                    height: 43,
                    // height: MediaQuery.of(context).size.height/9,
                    width: MediaQuery.of(context).size.width * 0.90,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      cursorColor: buttonColor,
                      controller: emailComtroller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: buttonColor,
                          ),
                        ),
                        hintText: "Your Email",
                        hintStyle: text,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      cursorColor: buttonColor,
                      controller: feedController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "Your feedback is important to us.",
                        hintStyle: text,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: InkWell(
                      onTap: () => help(),
                      child: loading
                          ? Container(
                        height: 5,
                            width: 5,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                                // valueColor:
                                //     AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                          )
                          : Center(
                              child: Text(
                                'Send',
                                style: buttonText,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "We Are Available On",
                style: questionStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/logo/web.png',
                      color: buttonColor,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Text(
                    "www.user-app.com",
                    style: text,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.mail_outline,
                      color: buttonColor,
                    ),
                  ),
                  Text(
                    "Contact@sharebottle.com",
                    style: text,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.apps,
                      color: buttonColor,
                    ),
                  ),
                  Text(
                    "123456",
                    style: text,
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
