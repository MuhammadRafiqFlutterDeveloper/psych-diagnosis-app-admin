import 'dart:convert';
import 'dart:io';
import 'package:psych_diagnosis_admin/models/profile_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../views/screens/screen_dashboard.dart';

class PsychCompleteProfileController extends GetxController {
  var selectedImage;
  var base64Image;
  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      selectedImage = File(image.path);
      base64Image = base64Encode(selectedImage.readAsBytesSync());
    }
  }

  void uploadData(String uid, String Education, String material, String sex,
      String race, String about, String dateinput,) async {
    String Material = material.toString();
    String Sex = sex.toString();
    String Race = race.toString();
    String About = about;
    String Date = dateinput;
    String image = base64Image;
    String education = Education;

    try {
      if (base64Image.isEmpty) {
        displayMessage('Please Select Image');
      } else if (material.isEmpty) {
        displayMessage('Please Select Material Status');
      } else if (sex.isEmpty) {
        displayMessage('Please Select Gender');
      } else if (race.isEmpty) {
        displayMessage('Choose the Race');
      } else if (education.isEmpty) {
        displayMessage('Choose the Education');
      } else if (dateinput.isEmpty) {
        displayMessage('Choose the Date of Birth');
      } else if (about.isEmpty) {
        displayMessage('Please Enter something for yourself');
      } else {
        var user = model.User(
          race: Race,
          about: About,
          sex: Sex,
          status: Material,
          birth: Date.toString(),
          profile: image.toString(),
        );

        await FirebaseFirestore.instance
            .collection("admin")
            .doc(uid)
            .update(user.toMap())
            .then((value) {
          Get.to(ScreenDashboard());
        });
        displayMessage("Create profile successfully");
        print("DB stored");
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        String errorMessage = error.message ?? 'An error occurred';
        displayMessage(errorMessage);
      } else {
        displayMessage("An error occurred");
      }
    }
  }

  // void uploadData(String uid) async {
  //   try {
  //  else {
  //       isLoading.value = true;
  //
  //       final ref = FirebaseStorage.instance
  //           .ref()
  //           .child('admin')
  //           .child(uid + '.jpg');
  //       await ref.putFile(selectedImage);
  //       base64Image.value = await ref.getDownloadURL();
  //
  //       FirebaseFirestore.instance.collection('admin').doc(uid).update({
  //         'birth': dateinput.value.text.trim(),
  //         'race': race.value.toString().trim(),
  //         'sex': sex.value.toString().trim(),
  //         'status': material.value.toString().trim(),
  //         'about': about.value.text.trim(),
  //         'profile': base64Image.value,
  //         'education': education.value.toString().trim(),
  //       });
  //
  //       isLoading.value = false;
  //       displayMessage("Create Profile successfully");
  //       Get.to(ScreenDashboard());
  //     }
  //     isLoading.value = false;
  //   } catch (error) {
  //     displayMessage(error.toString());
  //   }
  // }
}

// class PsychCompleteProfileController extends GetxController {
//   var isLoading = false.obs;
//   var selectedImage;
//   var base64Image = ''.obs;
//   var material = ''.obs;
//   var sex = ''.obs;
//   var race = ''.obs;
//   var education = ''.obs;
//   var dateinput = TextEditingController().obs;
//   var about = TextEditingController().obs;
//
// // ...
//
//   List<String> items = [
//     'Married',
//     'Living with Someone',
//     'Widowed',
//     'Separated',
//     'Divorced',
//     'Never Married',
//   ];
//
//   List<String> sexItem = [
//     'Male',
//     'Female',
//     'Other',
//   ];
//
//   List<String> raceItem = [
//     'White',
//     'Black',
//     'Hispanic',
//     'Asian',
//     'Portuguese',
//     'Other',
//   ];
//
//   List<String> eduItems = [
//     'Matriculation',
//     'Intermediate',
//     'Graduation',
//     'M Phil',
//     'Phd',
//     'Other',
//   ];
//
// // ...
//
//   Future<void> chooseImage(type) async {
//     var image;
//     if (type == "camera") {
//       image = await ImagePicker().pickImage(
//         source: ImageSource.camera,
//       );
//     } else {
//       image = await ImagePicker().pickImage(
//         source: ImageSource.gallery,
//       );
//     }
//     if (image != null) {
//       selectedImage = File(image.path);
//       base64Image.value = base64Encode(selectedImage.readAsBytesSync());
//     }
//   }
//
//   void uploadData(String uid) async {
//     try {
//       if (base64Image.value.isEmpty) {
//         displayMessage('Please Select Image');
//       } else if (material.value == "") {
//         displayMessage('Please Select Material Status');
//       } else if (sex.value == "") {
//         displayMessage('Please Select Gender');
//       } else if (race.value == '') {
//         displayMessage('Choose the Race');
//       } else if (education.value == '') {
//         displayMessage('Choose the Education');
//       } else if (dateinput.value.text.isEmpty) {
//         displayMessage('Choose the Date of Birth');
//       } else if (about.value.text.isEmpty) {
//         displayMessage('Please Enter something for yourself');
//       } else {
//         isLoading.value = true;
//
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('admin')
//             .child(uid + '.jpg');
//         await ref.putFile(selectedImage);
//         base64Image.value = await ref.getDownloadURL();
//
//         FirebaseFirestore.instance.collection('admin').doc(uid).update({
//           'birth': dateinput.value.text.trim(),
//           'race': race.value.toString().trim(),
//           'sex': sex.value.toString().trim(),
//           'status': material.value.toString().trim(),
//           'about': about.value.text.trim(),
//           'profile': base64Image.value,
//           'education': education.value.toString().trim(),
//         });
//
//         isLoading.value = false;
//         displayMessage("Create Profile successfully");
//         Get.to(ScreenDashboard());
//       }
//       isLoading.value = false;
//     } catch (error) {
//       displayMessage(error.toString());
//     }
//   }
// }
