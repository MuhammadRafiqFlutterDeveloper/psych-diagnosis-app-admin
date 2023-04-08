import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/main.dart';
import 'package:psych_diagnosis_admin/views/accounts/payment_method.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';

class unlock_admin extends StatefulWidget {
  final String uid;
  const unlock_admin({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<unlock_admin> createState() => _unlock_adminState();
}

class _unlock_adminState extends State<unlock_admin> {
  var currentIndex = 0;
  var index = 0;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.24,
              child: Text(
                textAlign: TextAlign.left,
                'Unlock Additional Admin Access',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 51,
              width: MediaQuery.of(context).size.width / 1.30,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: buttonColor,
                  ),
                  backgroundColor:
                      currentIndex == 1 ? buttonColor : Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(
                    () {
                      currentIndex = 1;
                      index = 1;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Monthly',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: currentIndex == 1 ? Colors.white : buttonColor,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '\$5.00 / ',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: currentIndex == 1 ? Colors.white : buttonColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Month',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: currentIndex == 1
                                  ? Colors.white
                                  : buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 51,
              width: MediaQuery.of(context).size.width / 1.30,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: buttonColor),
                  backgroundColor:
                      currentIndex == 2 ? buttonColor : Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(
                    () {
                      currentIndex = 2;
                      index = 2;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Yearly',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: currentIndex == 2 ? Colors.white : buttonColor,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '\$50.00 / ',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: currentIndex == 2 ? Colors.white : buttonColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Yearly',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: currentIndex == 2
                                  ? Colors.white
                                  : buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
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
                  if (currentIndex == 0) {
                    displayMessage('Please Select one');
                  } else {
                    openScreen(
                      context,
                      PaymentMethod(
                        uid: widget.uid,
                      ),
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: buttonText,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.30,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resore Purchases',
                  style: TextStyle(
                    color: buttonColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.30,
              child: Text(
                textAlign: TextAlign.center,
                "Unless you Cancel at least 24 hours before the end of the month, Until will be automatically charged \$ 10.00 for next month's Subscription. ",
                style: questionStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
