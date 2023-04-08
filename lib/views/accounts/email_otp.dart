import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class EmailOtpVarification extends StatefulWidget {
  const EmailOtpVarification({super.key});

  @override
  State<EmailOtpVarification> createState() => _EmailOtpVarificationState();
}

class _EmailOtpVarificationState extends State<EmailOtpVarification> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: email,
                        decoration:  InputDecoration(
                          hintText: "User Email",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        myauth.setConfig(
                            appName: "PsychDiagnosis",
                            userEmail: email.text,
                            otpLength: 4,
                            otpType: OTPType.digitsOnly,
                        );
                        if (await myauth.sendOTP() == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(
                                "OTP has been sent",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(
                                "Oops, OTP send failed",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Send OTP",
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: otp,
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (await myauth.verifyOTP(otp: otp.text) == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text(
                                  "OTP is verified",
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text("Invalid OTP",),
                              ),
                            );
                          }
                        },
                        child: Text("Verify",),),
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
