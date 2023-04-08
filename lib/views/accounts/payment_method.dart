import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psych_diagnosis_admin/views/accounts/accounts_psych_complete_profile.dart';
import 'package:psych_diagnosis_admin/views/constants/colors.dart';

class PaymentMethod extends StatefulWidget {
  final String uid;
  const PaymentMethod({super.key, required this.uid});
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _selectedValue = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
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
          "Payment Method",
          style: appbarStyle,
        ),
      ),
      body: Column(
        children: [
          RadioListTile(
            activeColor: buttonColor,
            secondary: Image.asset(
              'assets/logo/google.png',
              height: 50,
              width: 50,
            ),
            controlAffinity: ListTileControlAffinity.trailing,
            value: 1,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(
                () {
                  _selectedValue = value!;
                  if (value == 1) {
                    _scaffoldKey.currentState!.showBottomSheet(
                      (context) => Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(10, 10),
                                blurRadius: 20,
                                spreadRadius: 10)
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Google Pay',
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    'Monthly \nSubscription',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.all(20),
                                  child: RichText(
                                    text: TextSpan(
                                      text: '\$270.00',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n+ Tex ',
                                          style: textFieldStyle,
                                        ),
                                        // TextSpan(
                                        //   text: '${Icon(Icons.info_outline,color: Colors.black,)}',
                                        //
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.black,
                              ),
                              title: Text('Text Card, always Approves'),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.30,
                              child: MaterialButton(
                                onPressed: () {
                                  openScreen(
                                    context,
                                    ScreenPsychCompleteProfile(
                                      uid: widget.uid,
                                    ),
                                  );
                                },
                                // uplodedata(),
                                color: buttonColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: _isLoading
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : Text(
                                        '1-Tap buy',
                                        style: buttonText,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
            title: Text(
              "Google Pay",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          RadioListTile(
            activeColor: buttonColor,
            secondary: Icon(
              Icons.apple_outlined,
              color: Colors.black,
              size: 50,
            ),
            controlAffinity: ListTileControlAffinity.trailing,
            value: 2,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(
                () {
                  _selectedValue = value!;
                  if (value == 2) {
                    _scaffoldKey.currentState!.showBottomSheet(
                      (context) => Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(10, 10),
                                blurRadius: 20,
                                spreadRadius: 10)
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.apple_outlined,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Pay',
                                style: GoogleFonts.getFont(
                                  'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Text(
                                'Cancel',
                                style: GoogleFonts.getFont(
                                  'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff6893EA),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    'Subtotal',
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    '\$270',
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    'Pay NIKE',
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    '\$270',
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  openScreen(
                                    context,
                                    ScreenPsychCompleteProfile(
                                      uid: widget.uid,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/logo/button.png',
                                  height: 85,
                                  width: 85,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Confirm With Side Button',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff6893EA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
            title: Text(
              "Apple Pay",
              style: GoogleFonts.getFont(
                'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
