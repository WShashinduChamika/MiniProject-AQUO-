import 'dart:io';

import 'package:aquo/global.dart';
import 'package:aquo/screens/user.dart';
import 'package:aquo/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("User");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseServices _db = DatabaseServices();

  Uint8List? _image;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _contactNumber = TextEditingController();
  TextEditingController _systemID = TextEditingController();

  String firstName = "";
  String lastName = "";
  String email = "";
  String contactNumber = "";
  String SystemID = "";
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 812.h,
              width: 375.w,
              child: Stack(
                children: [
                  Container(
                    height: 349.54.h,
                    width: 375.w,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4553C6), Color(0xFF232A63)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18.h),
                    width: 375.w,
                    height: 48.h,
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserProfile(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30.w),
                            child: Image(
                              height: 20.h,
                              width: 10.w,
                              image: AssetImage('images/user/back.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 108.w),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'Avenir-Heavy',
                              fontSize: 18.sp,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            //saveData(_image!);
                            print("update");
                            //print(emailUID);
                            setInputValue(
                                isGmailUser ? _auth.currentUser!.uid : emailUID);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 68.w),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'Avenir-Heavy',
                                fontSize: 18.sp,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 93.h,
                    left: 120.w,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 60.r,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : imageUrl.isEmpty
                            ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage: AssetImage('images/user/user.png'),
                              )
                            : CircleAvatar(
                                radius: 60.r,
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                  ),
                  Positioned(
                    top: 163.h,
                    left: 206.w,
                    child: IconButton(
                      iconSize: 25.h,
                      color: Color.fromARGB(186, 255, 255, 255),
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () async {
                        Uint8List? img = await pickImage(ImageSource.gallery);
                        setState(() {
                          if (img != null) {
                            _image = img;
                            //print(img);
                          }
                        });
                      },
                    ),
                  ),
                  Positioned(
                    left: 22.w,
                    top: 268.h,
                    child: Container(
                      height: 490.h,
                      width: 331.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                        color: const Color(0xFFFFFFFF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 10,
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          setUserData("FirstName", TextInputType.name,
                              _firstnameController, firstName),
                          setUserData("LastName", TextInputType.name,
                              _lastnameController, lastName),
                          setUserData("Email", TextInputType.emailAddress,
                              _emailController, email),
                          setUserData("ContactNumber", TextInputType.phone,
                              _contactNumber, contactNumber),
                          setUserData(
                              "SystemID", TextInputType.name, _systemID, SystemID),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  Future<String> uploadImageToStorage(
      String childName, Uint8List fileData) async {
    Reference ref = _storage.ref(childName);

    // Convert Uint8List to File
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = '$tempPath/$childName';
    File file = File(filePath);
    await file.writeAsBytes(fileData);

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    //print(downloadURL);
    return downloadURL;
  }

  Future saveData(Uint8List file, String uid) async {
    try {
      String url = await uploadImageToStorage("User Profile", file);
      print(url);
      await userCollection.doc(uid).update({
        "Profile-img": url,
      }).then((value) => print("Success"));
    } catch (e) {
      print(e.toString());
    }
  }

  Widget setUserData(String Title, TextInputType inputType,
      TextEditingController controller, String hintText) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      height: 52.h,
      width: 286.45.w,
      decoration: BoxDecoration(
        // color: Colors.amber,
        border: Border(
          bottom: BorderSide(
            width: 1.w,
            color: Color(0xFF707070).withOpacity(0.6),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.h, left: 5.w),
            child: Text(
              Title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF2D3934).withOpacity(0.56),
              ),
            ),
          ),
          Container(
            height: 30.h,
            margin: EdgeInsets.only(top: 6.h, left: 5.w),
            child: TextFormField(
              // Use TextFormField instead of TextField
              enabled: Title == "Email"
                  ? isGmailUser
                      ? true
                      : false
                  : true,
              keyboardType: inputType,
              cursorColor: const Color(0xFF2D3934).withOpacity(0.85),
              controller: controller,
              obscureText: false,
              autocorrect: true,
              enableSuggestions: false,
              style: TextStyle(
                fontFamily: 'Lato',
                color: const Color(0xFF2D3934).withOpacity(0.85),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
              decoration: InputDecoration(
                // Removed unnecessary IconButton for non-password fields

                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'Lato',
                  color: const Color(0xFF2D3934).withOpacity(0.85),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _db.getUser(uid);
      if (documentSnapshot.exists) {
        print("doc ${documentSnapshot['FirstName']}");
        setState(() {
          firstName = documentSnapshot['FirstName'];
          lastName = documentSnapshot['LastName'];
          email = documentSnapshot['Email'];
          contactNumber = documentSnapshot['ContactNumber'];
          SystemID = documentSnapshot['SystemID'];
          imageUrl = documentSnapshot?['Profile-img'].trim();
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData(isGmailUser ? _auth.currentUser!.uid : emailUID);
  }

  Future setInputValue(String uid) async {
    print(uid);
    DocumentSnapshot documentSnapshot = await _db.getUser(uid);

    if (documentSnapshot.exists) {
      setState(() {
        firstName = _firstnameController.text.isNotEmpty
            ? _firstnameController.text
            : documentSnapshot['FirstName'];
        lastName = _lastnameController.text.isNotEmpty
            ? _lastnameController.text
            : documentSnapshot['LastName'];
        contactNumber = _contactNumber.text.isNotEmpty
            ? _contactNumber.text
            : documentSnapshot['ContactNumber'];
        SystemID = _systemID.text.isNotEmpty
            ? _systemID.text
            : documentSnapshot['SystemID'];
        email = _emailController.text.isNotEmpty
            ? _emailController.text
            : documentSnapshot['Email'];
        systemID = SystemID;
      });
    } else {}
    print(systemID);
    await _db.updateUser(
      uid,
      firstName,
      lastName,
      email,
      contactNumber,
      SystemID,
    );
    if (_image != null) {
      saveData(_image!, uid);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserProfile(),
      ),
    );
  }
}
