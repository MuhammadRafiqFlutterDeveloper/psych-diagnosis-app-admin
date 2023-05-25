import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class OTPController extends GetxController {
  String savedOtp = "";

  Future<void> sendOtpCode(String email, String fName, String lName) async {
    String otp = generateOTP();
    String appName = "Psych Diagnosis"; // Replace with your app name

    final body = {
      'to': email,
      'message': "Hey <br><br>" +
          "<b>$fName $lName</b><br><br>" +
          "You're almost ready to start finding solutions with<br><br>" +
          "<b><font color='blue'>$appName</font></b><br><br>" +
          "Simply copy this code:<br><br>" +
          "<b><font color='blue'>$otp</font></b><br><br>" +
          "and paste it in your app for signup completion.",
      'subject': 'Psych Diagnosis'
    };

    final response = await http.post(
      Uri.parse(
          "https://apis.appistaan.com/mailapi/index.php?key=sk286292djd926d"),
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      saveValue('otp2', otp);
      print("Sent");
      print(otp.toString());
      displayMessage("Otp Send successfully");
    } else {
      print("Failed to send OTP");
    }
  }

  Future<void> saveValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> loadValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedOtp = prefs.getString(key)!;
    print(savedOtp);
  }

  String generateOTP() {
    int length = 4; // Length of the OTP
    String characters = '0123456789'; // Characters to use for the OTP
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += characters[Random().nextInt(characters.length)];
      print(otp);
    }
    return otp;
  }
}
