import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class ScreenPsychCompleteProfile extends StatefulWidget {
  final String uid;

  const ScreenPsychCompleteProfile({super.key, required this.uid});
  @override
  State<ScreenPsychCompleteProfile> createState() =>
      _ScreenPsychCompleteProfileState();
}

class _ScreenPsychCompleteProfileState
    extends State<ScreenPsychCompleteProfile> {
  bool _isLoading = false;

  final _signUpFormKey = GlobalKey<FormState>();
  final PsychCompleteProfileController _controller =
      Get.put(PsychCompleteProfileController());
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
  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _signUpFormKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Let’s Complete Profile',
                      style: appbarStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 115,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: buttonColor,
                            width: 1.5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: buttonColor.withOpacity(0.50),
                          backgroundImage: _controller.selectedImage == null
                              ? NetworkImage('assets/logo/doctor.png')
                                  as ImageProvider
                              : FileImage(_controller.selectedImage!),
                        ),
                      ),
                      Positioned(
                        top: 65,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: material,
                      hint: Text(
                        'Marital Status',
                        style: textFieldStyle,
                      ),
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
                            style: GoogleFonts.getFont('Roboto',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: sex,
                      hint: Text(
                        'Sex',
                        style: textFieldStyle,
                      ),
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
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: race,
                      hint: Text(
                        'Race',
                        style: textFieldStyle,
                      ),
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
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: education,
                      hint: Text(
                        'Education',
                        style: textFieldStyle,
                      ),
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
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: TextField(
                      cursorColor: buttonColor,
                      controller: dateinput,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: buttonColor),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Date of birth",
                        hintStyle: textFieldStyle,
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
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      cursorColor: buttonColor,
                      controller: about,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: buttonColor),
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 10,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'About',
                          hintStyle: textFieldStyle),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Write Something for About Your";
                        } else
                          return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 43,
                  width: MediaQuery.of(context).size.width / 1.30,
                  child: MaterialButton(
                    onPressed: () => _controller.uploadData(
                        widget.uid,
                        sex.toString(),
                        about.text,
                        material.toString(),
                        race.toString(),
                        dateinput.text,
                        education.toString()),
                    color: buttonColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Finish',
                            style: buttonText,
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
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
                  style: GoogleFonts.getFont('Roboto', color: buttonColor),
                ),
                onTap: () {
                  _controller.chooseImage("Gallery");
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
                    style: GoogleFonts.getFont('Roboto', color: buttonColor),
                  ),
                  onTap: () {
                    _controller.chooseImage("camera");
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  var about = TextEditingController();
}

// class _ScreenPsychCompleteProfileState
//     extends State<ScreenPsychCompleteProfile> {
//   final PsychCompleteProfileController _controller =
//       Get.put(PsychCompleteProfileController());
//   // List<String> items = [
//   //   'Married',
//   //   'Living with Someone',
//   //   'Widowed',
//   //   'Separated',
//   //   'Divorced',
//   //   'Never Married',
//   // ];
//   //
//   // List<String> sexItem = [
//   //   'Male',
//   //   'Female',
//   //   'Other',
//   // ];
//   //
//   // List<String> raceItem = [
//   //   'White',
//   //   'Black',
//   //   'Hispanic',
//   //   'Asian',
//   //   'Portuguese',
//   //   'Other',
//   // ];
//   //
//   // List<String> eduItems = [
//   //   'Matriculation',
//   //   'Intermediate',
//   //   'Graduation',
//   //   'M Phil',
//   //   'Phd',
//   //   'Other',
//   // ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Complete Profile'),
//       ),
//       body: Obx(
//             () => SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: 115,
//                   width: 100,
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: 100,
//                         width: 100,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: buttonColor,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundColor: buttonColor.withOpacity(0.50),
//                           backgroundImage: _controller.selectedImage == null
//                               ? NetworkImage('assets/logo/doctor.png')
//                           as ImageProvider
//                               : FileImage(_controller.selectedImage!),
//                         ),
//                       ),
//                       Positioned(
//                         top: 65,
//                         bottom: 0,
//                         right: 0,
//                         child: IconButton(
//                           onPressed: () {
//                             _choiseShowDialog(context);
//                           },
//                           icon: Image.asset(
//                             'assets/logo/img_7.png',
//                             height: 36,
//                             width: 36,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: _controller.dateinput,
//                   decoration: InputDecoration(
//                     labelText: 'Date of Birth',
//                     hintText: 'Select date',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: _controller.race.isNotEmpty ? raceItem : null,
//                   items: [
//                     DropdownMenuItem(
//                       child: Text('Chinese'),
//                       value: 'Chinese',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Malay'),
//                       value: 'Malay',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Indian'),
//                       value: 'Indian',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Others'),
//                       value: 'Others',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       raceItem = value!;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Race',
//                     hintText: 'Select race',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: sex != null ? sex : null,
//                   items: [
//                     DropdownMenuItem(
//                       child: Text('Male'),
//                       value: 'Male',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Female'),
//                       value: 'Female',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       sex = value!;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Gender',
//                     hintText: 'Select gender',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: material != null ? material : null,
//                   items: [
//                     DropdownMenuItem(
//                       child: Text('Single'),
//                       value: 'Single',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Married'),
//                       value: 'Married',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Divorced'),
//                       value: 'Divorced',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       material = value!;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Material Status',
//                     hintText: 'Select material status',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: about,
//                   maxLines: 5,
//                   decoration: InputDecoration(
//                     labelText: 'About',
//                     hintText: 'Enter something about yourself',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 DropdownButtonFormField<String>(
//                   value: educationItem.isNotEmpty ? educationItem : null,
//                   items: [
//                     DropdownMenuItem(
//                       child: Text('Primary'),
//                       value: 'Primary',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('Secondary'),
//                       value: 'Secondary',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('University'),
//                       value: 'University',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('College'),
//                       value: 'College',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       educationItem = value!;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Education',
//                     hintText: 'Select education level',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Profile newProfile = Profile(
//                       birth: dateinput.text,
//                       race: raceItem,
//                       sex: sex,
//                       status: material,
//                       about: about.text,
//                       education: educationItem,
//                     );
//                     _profileController.updateProfile(newProfile);
//                     _profileController.uploadData(
//                       widget.uid,
//                       selectedImage,
//                     );
//                   },
//                   child: Text('Save'),
//                 ),
//                 SizedBox(height: 20),
//                 Obx(
//                       () => _profileController.isLoading.value
//                       ? CircularProgressIndicator()
//                       : Container(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//       // body: SingleChildScrollView(
//       //   child: Padding(
//       //     padding: EdgeInsets.all(16.0),
//       //     child: Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         // Add your UI widgets here
//       //         Text('Select Image'),
//       //         Container(
//       //           height: 115,
//       //           width: 100,
//       //           child: Stack(
//       //             children: [
//       //               Container(
//       //                 height: 100,
//       //                 width: 100,
//       //                 padding: EdgeInsets.all(10),
//       //                 decoration: BoxDecoration(
//       //                   color: Colors.white,
//       //                   shape: BoxShape.circle,
//       //                   border: Border.all(
//       //                     color: buttonColor,
//       //                     width: 1.5,
//       //                   ),
//       //                 ),
//       //                 child: CircleAvatar(
//       //                   radius: 50,
//       //                   backgroundColor: buttonColor.withOpacity(0.50),
//       //                   backgroundImage: _controller.selectedImage == null
//       //                       ? NetworkImage('assets/logo/doctor.png')
//       //                           as ImageProvider
//       //                       : FileImage(_controller.selectedImage!),
//       //                 ),
//       //               ),
//       //               Positioned(
//       //                 top: 65,
//       //                 bottom: 0,
//       //                 right: 0,
//       //                 child: IconButton(
//       //                   onPressed: () {
//       //                     _choiseShowDialog(context);
//       //                   },
//       //                   icon: Image.asset(
//       //                     'assets/logo/img_7.png',
//       //                     height: 36,
//       //                     width: 36,
//       //                   ),
//       //                 ),
//       //               ),
//       //             ],
//       //           ),
//       //         ),
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('Material Status'),
//       //         DropdownButton<String>(
//       //           value: _controller.material,
//       //           onChanged: (value) {
//       //             _controller.material = value!;
//       //           },
//       //           items: items
//       //               .map((item) => DropdownMenuItem<String>(
//       //                     value: item,
//       //                     child: Text(item),
//       //                   ))
//       //               .toList(),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('Gender'),
//       //         DropdownButton<String>(
//       //           value: _controller.sex,
//       //           onChanged: (value) {
//       //             _controller.sex = value!;
//       //           },
//       //           items: sexItem
//       //               .map((item) => DropdownMenuItem<String>(
//       //                     value: item,
//       //                     child: Text(item),
//       //                   ))
//       //               .toList(),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('Race'),
//       //         DropdownButton<String>(
//       //           value: _controller.race,
//       //           onChanged: (value) {
//       //             _controller.race = value!;
//       //           },
//       //           items: raceItem
//       //               .map((item) => DropdownMenuItem<String>(
//       //                     value: item,
//       //                     child: Text(item),
//       //                   ))
//       //               .toList(),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('Education'),
//       //         DropdownButton<String>(
//       //           value: _controller.education,
//       //           onChanged: (value) {
//       //             _controller.education = value!;
//       //           },
//       //           items: eduItems
//       //               .map((item) => DropdownMenuItem<String>(
//       //                     value: item,
//       //                     child: Text(item),
//       //                   ))
//       //               .toList(),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('Date of Birth'),
//       //         Obx(
//       //           () => TextField(
//       //             controller: _controller.dateinput,
//       //             decoration: InputDecoration(
//       //               hintText: 'Select date',
//       //             ),
//       //             onTap: () async {
//       //               DateTime? pickedDate = await showDatePicker(
//       //                 context: context,
//       //                 initialDate: DateTime.now(),
//       //                 firstDate: DateTime(1900),
//       //                 lastDate: DateTime.now(),
//       //               );
//       //               if (pickedDate != null) {
//       //                 _controller.dateinput.text =
//       //                     pickedDate.toString(); // Format the date as required
//       //               }
//       //             },
//       //           ),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Text('About'),
//       //         Obx(
//       //           () => TextField(
//       //             controller: _controller.about,
//       //             decoration: InputDecoration(
//       //               hintText: 'Enter something about yourself',
//       //             ),
//       //           ),
//       //         ),
//       //
//       //         SizedBox(height: 16.0),
//       //
//       //         Obx(
//       //           () => _controller.isLoading.value
//       //               ? CircularProgressIndicator()
//       //               : ElevatedButton(
//       //                   onPressed: () {
//       //                     _controller.uploadData(widget.uid);
//       //                   },
//       //                   child: Text('Submit'),
//       //                 ),
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
//
//   Future<void> _choiseShowDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Select Image From"),
//             actions: [
//               GestureDetector(
//                 child: Text(
//                   "Gallery",
//                   style: GoogleFonts.getFont('Roboto', color: buttonColor),
//                 ),
//                 onTap: () {
//                   _controller.chooseImage("Gallery");
//                   Navigator.pop(context);
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: EdgeInsets.all(10),
//                 child: GestureDetector(
//                   child: Text(
//                     "camera",
//                     style: GoogleFonts.getFont('Roboto', color: buttonColor),
//                   ),
//                   onTap: () {
//                     _controller.chooseImage("camera");
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }

// File? selectedImage;
// var base64Image = "";
//
// Future<void> chooseImage(type) async {
//   var image;
//   if (type == "camera") {
//     image = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//   } else {
//     image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//   }
//   if (image != null) {
//     setState(() {
//       selectedImage = File(image.path);
//       base64Image = base64Encode(selectedImage!.readAsBytesSync());
//       // won't have any error now
//     });
//   }
// }

// void uplodedata() async {
//   try {
//     if (base64Image.isEmpty) {
//       displayMessage('Please Select Image');
//     } else if (material == null) {
//       displayMessage('Please Select Material Status');
//     } else if (sex == null) {
//       displayMessage('Please Select Gender');
//     }else if (raceItem == '') {
//       displayMessage('chose the Race');
//     } else if (eduItems == '') {
//       displayMessage('chose the Race');
//     }  else if (dateinput.text.isEmpty) {
//       displayMessage('Chose The Date of Birth');
//     }
//     else if (about.text.isEmpty) {
//       displayMessage('Please Enter something for yourSelf');
//     } else {
//       setState(() {
//         _isLoading = true;
//       });
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('admin')
//           .child(widget.uid + '.jpg');
//       await ref.putFile(selectedImage!);
//       base64Image = await ref.getDownloadURL();
//       FirebaseFirestore.instance.collection('admin').doc(widget.uid).update({
//         'birth': dateinput.text.trim(),
//         'race': race.toString().trim(),
//         'sex': sex.toString().trim(),
//         'status': material.toString().trim(),
//         'about': about.text.trim(),
//         'profile': base64Image,
//         'education': education.toString().trim(),
//       });
//
//       setState(() {
//         _isLoading = false;
//       });
//       displayMessage("Create Profile successfully");
//       openScreen(
//         context,
//         ScreenDashboard(),
//       );
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   } catch (error) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(error.toString())));
//   }
// }
