import 'package:aquo/screens/home.dart';
import 'package:aquo/services/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseServices _db = DatabaseServices();
  String time = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF4654C7), Color(0xFF5075ED)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: Column(children: [
            Container(
              width: 375.w,
              height: 48.h,
              margin: EdgeInsets.only(top: 32.h, bottom: 0.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 30.w,
                      ),
                      child: Image(
                        image: AssetImage('images/sign_in/left_arrow.png'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 91.w),
                    child: Text(
                      'Notification',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFEFFAF6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: getStream(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget getStream() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Notifications')
          .where('UID', isEqualTo: _auth.currentUser!.uid)
          .orderBy('Received Date Time', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              padding: EdgeInsets.only(top: 320.h, bottom: 320.h),
              height: 0.h,
              width: 55.w,
              //color: Colors.white,
              child: CircularProgressIndicator(
                color: Colors.white,
              ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print(_auth.currentUser!.uid);
          return Text('');
        } else {
          // Display the notifications

          return ListView.builder(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var notificationDoc = snapshot.data!.docs[index];
              var notificationData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var title =
                  notificationData["Notification Title"] ?? "Default Title";
              var message =
                  notificationData["Notification Message"] ?? "Default Message";
              var receviedDateTime =
                  notificationData["Received Date Time"] ?? "1 hour ago";
              time = timeDifference(receviedDateTime);

              return Dismissible(
                 key: Key(notificationDoc.id),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) async{
                  await _db.deleteNotification(notificationDoc.id);
                },
                child: Container(
                  height: 77.h,
                  width: 327.h,
                  margin: EdgeInsets.only(top: 40.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    color: Color(0xFF5178F1),
                  ),
                  child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 26.w),
                          child: Image(
                            height: 26.h,
                            width: 22.w,
                            image: const AssetImage(
                                'images/notification_screen/notification_icon.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.w, top: 15.h),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFEFFAF6)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  child: Text(
                                    message, 
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFEFFAF6)),
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25.w, top: 35.h),
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFFCCCCCC),
                            ),
                          ),
                        )
                      ]),
                ),
              );
            },
          );
        }
      },
    );
  }

  String timeDifference(String receivedDateTime) {
    DateTime receivedDate;
    try {
      // Attempt to parse the received date time string to a DateTime object
      receivedDate = DateTime.parse(receivedDateTime);
    } catch (e) {
      // If parsing fails, return a default message
      return "Invalid date format";
    }

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference
    Duration difference = now.difference(receivedDate);

    // Determine the appropriate time difference string
    if (difference.inDays >= 1) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }
}
