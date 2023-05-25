import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../controllers/credential_controller.dart';
import '../../controllers/opt_controller.dart';
import '../../main.dart';
import '../constants/colors.dart';

class ScreenPsychVerification extends StatefulWidget {
  final String email;
  final String fName;
  final String lName;

  const ScreenPsychVerification(
      {required this.email, required this.fName, required this.lName});

  @override
  _ScreenPsychVerificationState createState() =>
      _ScreenPsychVerificationState();
}

class _ScreenPsychVerificationState extends State<ScreenPsychVerification> {
  bool _isLoading = false;
  final _codeController = TextEditingController();
  final RegistrationController _controller = Get.put(RegistrationController());
  final OTPController controller = Get.put(OTPController());
  Future<void> sendOtpCode() async {
    controller.sendOtpCode(widget.email, widget.fName, widget.lName);
  }

  @override
  void initState() {
    sendOtpCode();
    super.initState();
    print(widget.email);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.20,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Verification",
                    style: appbarStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.20,
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter the OTP code sent to your email ",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Pinput(
                  textInputAction: TextInputAction.next,
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  length: 4,
                  obscureText: false,
                  closeKeyboardWhenCompleted: true,
                  defaultPinTheme: PinTheme(
                    margin: EdgeInsets.all(8),
                    height: 45,
                    width: 45,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(blurRadius: 2, color: Colors.grey),
                      ],
                    ),
                  ),
                  onTap: () {
                    controller.loadValue("otp2");
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Did not receive a code?",
                style: GoogleFonts.getFont('Roboto',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    sendOtpCode();
                  },
                  child: Text(
                    "RESEND",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: buttonColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width / 1.30,
                child: MaterialButton(
                  onPressed: () {
                    controller.loadValue("otp2");
                    if (_codeController.text == "") {
                      displayMessage('Put the correct Otp');
                    } else if (_codeController.text == controller.savedOtp) {
                      _controller.Register();
                    } else {
                      displayMessage('Some Thing Went Wrong');
                    }
                  },
                  color: buttonColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Done',
                          style: buttonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //
  // Future<void> sendOtpCode() async {
  //   String otp = generateOTP();
  //   Map<String, String> body = {
  //     'to': widget.email,
  //     'message': "Hey \n" +
  //         "${widget.fName} ${widget.lName}" +
  //         ",\nyou're almost ready to start find Solution of Diagnosis. Simply Copy this code \n" +
  //         otp +
  //         "\n and paste in your  App for signup completion ",
  //     'subject': 'Psych Diagnosis'
  //   };
  //
  //   final response = await http.post(
  //       Uri.parse(
  //           "https://apis.appistaan.com/mailapi/index.php?key=sk286292djd926d"),
  //       body: body);
  //
  //   print(response);
  //
  //   if (response.statusCode == 200) {
  //     saveValue('otp2', otp);
  //     print("sent");
  //     print(otp.toString());
  //   }
  // }
  //
  // Future<void> saveValue(String key, String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(key, value);
  // }
  //
  // Future<void> loadValue(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     savedOtp = prefs.getString(key)!;
  //     print(savedOtp);
  //   });
  // }
  //
  // String generateOTP() {
  //   int length = 4; // Length of the OTP
  //   String characters = '0123456789'; // Characters to use for the OTP
  //   String otp = '';
  //   for (int i = 0; i < length; i++) {
  //     otp += characters[Random().nextInt(characters.length)];
  //     print(otp);
  //   }
  //   return otp;
  // }
}

// class _ScreenPsychVerificationState extends State<ScreenPsychVerification> {
//   bool _isLoading = false;
//   final _codeController = TextEditingController();
//   final otpController = Get.put(OtpController());
//   final RegistrationController _controller = Get.put(RegistrationController());
//
//   @override
//   void initState() {
//     super.initState();
//     print(widget.email);
//     sendOtp();
//   }
//
//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }
//
//   void sendOtp() {
//     otpController.sendOtp(widget.email, widget.fName, widget.lName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.20,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Verification",
//                     style: appbarStyle,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.20,
//                 height: 30,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Enter the OTP code sent to your email ",
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 30),
//                 child: Pinput(
//                   textInputAction: TextInputAction.next,
//                   controller: _codeController,
//                   keyboardType: TextInputType.number,
//                   length: 4,
//                   obscureText: false,
//                   closeKeyboardWhenCompleted: true,
//                   defaultPinTheme: PinTheme(
//                     margin: EdgeInsets.all(8),
//                     height: 45,
//                     width: 45,
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white,
//                     ),
//                     decoration: BoxDecoration(
//                       color: buttonColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(blurRadius: 2, color: Colors.grey),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "Did not receive a code?",
//                 style: GoogleFonts.getFont('Roboto',
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Container(
//                 child: TextButton(
//                   onPressed: () {
//                     sendOtp();
//                   },
//                   child: Text(
//                     "RESEND",
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                       color: buttonColor,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               SizedBox(
//                 height: 43,
//                 width: MediaQuery.of(context).size.width / 1.30,
//                 child: MaterialButton(
//                   onPressed: () {
//                     if (_codeController.text == "") {
//                       displayMessage('Put the correct Otp');
//                     } else if (_codeController.text ==
//                         otpController.savedOtp.value) {
//                       _controller.Register();
//                     } else {
//                       displayMessage('Something Went Wrong');
//                     }
//                   },
//                   color: buttonColor,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   child: _isLoading
//                       ? CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : Text(
//                           'Done',
//                           style: buttonText,
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';
// import '../../controllers/credential_controller.dart';
// import '../../controllers/opt_controller.dart';
// import '../../main.dart';
// import '../constants/colors.dart';
//
// class ScreenPsychVerification extends StatefulWidget {
// final email;
// final fName;
// final lName;
// ScreenPsychVerification({this.email, this.fName, this.lName});
//   @override
//   State<ScreenPsychVerification> createState() =>
//       _ScreenPsychVerificationState();
// }
// class _ScreenPsychVerificationState extends State<ScreenPsychVerification> {
//   bool _isLoading = false;
//   final _codeController = TextEditingController();
//   final otpController = Get.put(OtpController());
//   final RegistrationController _controller = Get.put(RegistrationController());
//
//   @override
//   void initState() {
//     super.initState();
//     print(widget.email);
//     sendOtp();
//   }
//
//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }
//
//   void sendOtp() {
//     otpController.sendOtp(widget.email, widget.fName, widget.lName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.20,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Verification",
//                     style: appbarStyle,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 2,),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 1.20,
//                 height: 30,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Enter the OTP code sent to your email ",
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 30),
//                 child: Pinput(
//                   textInputAction: TextInputAction.next,
//                   controller: _codeController,
//                   keyboardType: TextInputType.number,
//                   length: 4,
//                   obscureText: false,
//                   closeKeyboardWhenCompleted: true,
//                   defaultPinTheme: PinTheme(
//                     margin: EdgeInsets.all(8),
//                     height: 45,
//                     width: 45,
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white,
//                     ),
//                     decoration: BoxDecoration(
//                       color: buttonColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(blurRadius: 2, color: Colors.grey),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Text(
//                 "Did not receive a code?",
//                 style: GoogleFonts.getFont('Roboto',
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Container(
//                 child: TextButton(
//                   onPressed: () {
//                     sendOtp();
//                   },
//                   child: Text(
//                     "RESEND",
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                       color: buttonColor,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               SizedBox(
//                 height: 43,
//                 width: MediaQuery.of(context).size.width / 1.30,
//                 child: MaterialButton(
//                   onPressed: () {
//                     if (_codeController.text == "") {
//                       displayMessage('Put the correct Otp');
//                     } else if (_codeController.text == otpController.savedOtp.value) {
//                       _controller.Register();
//                     } else {
//                       displayMessage('Something Went Wrong');
//                     }
//                   },
//                   color: buttonColor,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   child: _isLoading
//                       ? CircularProgressIndicator(
//                     color: Colors.white,
//                   )
//                       : Text(
//                     'Done',
//                     style: buttonText,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
