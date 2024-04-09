// import 'package:aquo/home.dart';
// import 'package:aquo/map.dart';
//import 'package:aquo/reusablel_widgets/user_component/navigations.dart';
// import 'package:aquo/signin.dart';
import 'package:aquo/global.dart';
import 'package:aquo/reusable_widgets/user_components/navigations.dart';
import 'package:aquo/screens/home.dart';
import 'package:aquo/screens/map.dart';
import 'package:aquo/services/authenticate.dart';
import 'package:aquo/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthServices _auth2 = AuthServices();
  final DatabaseServices _db = DatabaseServices();

  String firstName = '';
  String lastName = "";
  String email = "";
  String userDp = "";

  @override
  Widget build(BuildContext context) {
    String uid = isGmailUser ? _auth.currentUser!.uid : emailUID;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                height: 812.h,
                width: 375.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF4553C6),
                    Color(0xFF232A63),
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                ),
                child: Column(
                  children: [
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
                                  builder: (context) => const HomeScreen(),
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
                              'My Profile',
                              style: TextStyle(
                                fontFamily: 'Avenir-Heavy',
                                fontSize: 18.sp,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 28.h),
                      height: 158.h,
                      width: 200.w,
                      // color: Colors.amber,
                      child: Column(
                        children: [
                          Container(
                              // ignore: unnecessary_null_comparison
                              child: !userDp.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 50.r,
                                      backgroundImage:
                                          AssetImage('images/user/user.png'),
                                    )
                                  : CircleAvatar(
                                      radius: 50.r,
                                      backgroundImage: NetworkImage("$userDp"),
                                    )),
                          // Container(
                          //   child: CircleAvatar(
                          //     radius: 40.r,
                          //     backgroundImage: NetworkImage("$userDp"),
                          //   ),
                          // ),
                          Container(
                            width: 200.w,
                            margin: EdgeInsets.only(top: 13.h,left: 20.w),
                            child: Text(
                              '$firstName $lastName',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFEFFAF6),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '$email',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFEFFAF6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      height: 60.h,
                      // color: Colors.amber,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 37.w),
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              color: Color(0xFFACDBFF),
                              child: Image(
                                image: AssetImage('images/user/plan.png'),
                                height: 40.h,
                                width: 23.w,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10.w,
                              top: 7.h,
                            ),
                            child: Text(
                              'Plan',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFEFFAF6),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 47.w, top: 10.h),
                            height: 40.h,
                            width: 2.w,
                            color: Color(0xFFD2D8CF),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.w),
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              color: Color(0xFF5483EF),
                              child: Image(
                                image: AssetImage('images/user/report.png'),
                                height: 40.h,
                                width: 23.w,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10.w,
                              top: 7.h,
                            ),
                            child: Text(
                              'Database',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFFEFFAF6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 437.h,
              child: Container(
                height: 375.h,
                width: 375.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
            Positioned(
              left: 24.w,
              top: 363.h,
              // left: width * 0.064,
              // top: height * 0.437,
              child: Container(
                height: 382.h,
                width: 327.w,
                // height: height * 0.5,
                // width: width * 0.872,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                  color: const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 22,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NavigatorComponent(
                      img1: 'images/user/home.png',
                      type: 'Edit Profile',
                      img3: 'images/user/user_back.png',
                      onTap: () {
                       
                      },
                    ),
                    NavigatorComponent(
                      img1: 'images/user/setting.png',
                      type: 'Setting',
                      img3: 'images/user/user_back.png',
                      onTap: () {},
                    ),
                    NavigatorComponent(
                      img1: 'images/user/a-share.png',
                      type: 'Call assistant',
                      img3: 'images/user/user_back.png',
                      onTap: () {},
                    ),
                    NavigatorComponent(
                      img1: 'images/user/support.png',
                      type: 'Support',
                      img3: 'images/user/user_back.png',
                      onTap: () {
                      },
                    ),
                    NavigatorComponent(
                      img1: 'images/user/location.png',
                      type: 'Set Location',
                      img3: 'images/user/user_back.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CurrentLocationMap(),
                          ),
                        );
                      },
                    ),
                    // NavigatorComponent(
                    //   img1: 'images/user/payments.png',
                    //   type: 'Payments',
                    //   img3: 'images/user/user_back.png',
                    //   onTap: () {},
                    // ),
                    NavigatorComponent(
                      img1: 'images/user/logout.png',
                      type: 'Log out',
                      img3: 'images/user/user_back.png',
                      onTap: () async {
                        await _auth2.signOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setUserDetails(String uid) async {
    DocumentSnapshot documentSnapshot = await _db.userCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      setState(() {
        firstName = documentSnapshot["FirstName"];
        lastName = documentSnapshot["LastName"];
        email = documentSnapshot["Email"];
        userDp = documentSnapshot?['Profile-img'].trim();
      });
    }
  }

  // void getUserDP(String uid) async {
  //   DocumentSnapshot documentSnapshot = await _db.getUserDP(uid);
  //   if (documentSnapshot.exists) {
  //     setState(() {
  //       userDp = documentSnapshot?['profile-img'].trim();
  //     });
  //     print("user dp" + userDp);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUserDP("23");
    setUserDetails(isGmailUser? _auth.currentUser!.uid: emailUID);
  }
}
