import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePsychAbout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
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
          'About',
          style: appbarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/logo/logo.png',
                height: 121,
                width: 135,
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: AutoSizeText(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  'An application created by Michael O. Ortiz, PMHNP-BC to support individuals in monitoring their symptoms in relation to their mental health.',
                  style: text,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contact us',
                      style: button,
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.width_wide_outlined,
                        color: buttonColor,
                      ),
                    ),
                    Text(
                      "www.userapp.com",
                      style:
                          text,
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
                      style:
                          text,
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
                        Icons.whatshot,
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
      ),
    );
  }
}
