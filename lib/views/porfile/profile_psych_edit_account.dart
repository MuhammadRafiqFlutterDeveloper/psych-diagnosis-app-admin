import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:psych_diagnosis_admin/main.dart';
import '../constants/colors.dart';

class ProfilePsychEditAccount extends StatefulWidget {
  final String profile;
  final String firstName;
  final String lastName;
  final String email;
  final String material;
  final String sex;
  final String birth;
  final String race;
  final String about;

  const ProfilePsychEditAccount(
      {super.key,
      required this.profile,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.material,
      required this.sex,
      required this.birth,
      required this.race,
      required this.about});

  @override
  State<ProfilePsychEditAccount> createState() =>
      _ProfilePsychEditAccountState();
}

class _ProfilePsychEditAccountState extends State<ProfilePsychEditAccount> {

  final TextEditingController fnameController = TextEditingController();
  var lanameController = TextEditingController();
  var emailController = TextEditingController();
  var aboutController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  String? material;
  var items = [
    'Married',
    'Living with Someone',
    'Widowed',
    'Separated',
    'Divorced',
    'Never Married',
  ];
  String? sex;
  var sexItem = [
    'Male',
    'Female',
    'Other',
  ];
  String? race;
  var raceItem = [
    'White',
    'Black',
    'Hispanic',
    'Asian',
    'Portuguese',
    'Other',
  ];
  String? education;
  var eduItems = [
    'Matriculation',
    'Intermediate',
    'Graduation',
    'M Phil',
    'Phd',
    'Other',
  ];

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: appbarStyle,
        ),
        centerTitle: true,
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
        elevation: 1,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 115,
                width: 100,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: buttonColor.withOpacity(0.50),
                      backgroundImage: selectedImage == null
                          ? NetworkImage('${widget.profile}') as ImageProvider
                          : FileImage(selectedImage!),
                    ),
                    Positioned(
                      top: 60,
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          _choiseShowDialog(context);
                        },
                        icon: Image.asset(
                          'assets/logo/img_7.png',
                          height: 36,
                          width: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'First Name',
                    style: textFieldStyle,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.10,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: fnameController..text = widget.firstName,
                  decoration: InputDecoration(

                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First Name Required";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.30,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Last Name',
                    style: textFieldStyle,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.10,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: lanameController..text = widget.lastName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last Name Required";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.30,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Email',
                    style: textFieldStyle,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.10,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: emailController..text = widget.email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Required";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.30,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Material Status',
                    style: textFieldStyle,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.10,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: material ?? items.first,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      material = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      material = value;
                    });
                  },
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: questionStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Sex',
                    style: textFieldStyle,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.10,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: sex ?? sexItem.first,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      sex = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      sex = value;
                    });
                  },
                  items: sexItem.map((String sexItem) {
                    return DropdownMenuItem(
                      value: sexItem,
                      child: Text(
                        sexItem,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Education',
                    style: textFieldStyle,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.10,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: education ?? eduItems.first,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      education = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      education = value;
                    });
                  },
                  items: eduItems.map((String eduItems) {
                    return DropdownMenuItem(
                      value: eduItems,
                      child: Text(
                        eduItems,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Race',
                    style: textFieldStyle,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.10,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: race ?? raceItem.first,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      race = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      race = value;
                    });
                  },
                  items: raceItem.map((String raceItem) {
                    return DropdownMenuItem(
                      value: raceItem,
                      child: Text(
                        raceItem,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Date of Birth',
                    style: textFieldStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.10,
                child: TextField(
                  cursorColor: buttonColor,
                  controller: dateinput..text = widget.birth,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(5000),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: buttonColor,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: buttonColor,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      print(
                          pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate);
                      setState(() {
                        dateinput.text =
                            formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.10,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'About',
                    style: textFieldStyle,
                  ),
                ),
              ),
              Container(

                width: MediaQuery.of(context).size.width / 1.10,
                child: TextFormField(
                  cursorColor: buttonColor,
                  controller: aboutController..text = widget.about,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First Name Required";
                    } else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 43,
                width: MediaQuery.of(context).size.width / 1.30,
                child: MaterialButton(
                  onPressed: () => uplodedata(),
                  color: buttonColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: isloading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Update',
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

  Future<void> _choiseShowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Image From"),
            actions: [
              GestureDetector(
                child: Text(
                  "Gallery",
                  style: TextStyle(color: buttonColor),
                ),
                onTap: () {
                  chooseImage("Gallery");
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  child: Text(
                    "camera",
                    style: TextStyle(color: buttonColor),
                  ),
                  onTap: () {
                    chooseImage("camera");
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  void uplodedata() async {
    var _auth = await FirebaseAuth.instance;
    try {
      setState(() {
        isloading = true;
      });
      final User? user = _auth.currentUser;
      final userid = user!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(userid + '.jpg');
      await ref.putFile(selectedImage!);
      base64Image = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('admin').doc(userid).update({
        'profile': base64Image,
        'firstName': fnameController.text.toString().trim(),
        'lastName': lanameController.text.toString().trim(),
        'email': emailController.text.toString().trim(),
        'birth': dateinput.text.trim(),
        'race': race.toString().trim(),
        'sex': sex.toString().trim(),
        'status': material.toString().trim(),
        'about': aboutController.text.trim(),
      });
      setState(() {
        isloading = false;
      });
      displayMessage("Data upload successfully");
      Navigator.pop(context);
    } catch (error) {
      displayMessage(error.toString());
    }
  }

  File? selectedImage;
  var base64Image = "";

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
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }


}
