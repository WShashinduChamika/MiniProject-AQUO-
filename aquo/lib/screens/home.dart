import 'package:aquo/global.dart';
import 'package:aquo/reusable_widgets/home_components/calender_&_weathertool_maintain/calernder.dart';
import 'package:aquo/reusable_widgets/home_components/calender_&_weathertool_maintain/weather_tool.dart';
import 'package:aquo/reusable_widgets/home_components/calender_&_weathertool_maintain/weather_tool_maintain.dart';
import 'package:aquo/reusable_widgets/home_components/cloudStatus_and_temp_%20tools/temp_cloud_tools.dart';
import 'package:aquo/reusable_widgets/home_components/cloudStatus_and_temp_%20tools/weather_tooltype01.dart';
import 'package:aquo/reusable_widgets/home_components/navbar.dart';
import 'package:aquo/reusable_widgets/home_components/status_level/status_level_list.dart';
import 'package:aquo/reusable_widgets/home_components/top_menu.dart';
import 'package:aquo/reusable_widgets/system_switches/main_switch.dart';
import 'package:aquo/reusable_widgets/system_switches/system_switch.dart';
import 'package:aquo/screens/default_home.dart';
import 'package:aquo/services/db.dart';
import 'package:aquo/services/notification.dart';
import 'package:aquo/services/weather.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMenuBarClicked = false; //varibale to check menubar status

  //variables to check the appear status of weather tool
  bool isTempratureClicked = false;
  bool isTempToolOn = false;
  bool isLightClicked = false;
  bool isLightToolOn = false;
  bool isWindClicked = false;
  bool isWindToolOn = false;
  bool isHumidityClicked = false;
  bool isHumidityToolOn = false;

  //variables to set weather details
  String cloudStatus = "";
  String temprature = "";
  String humidityE = "";
  String windSpeed = "";
  String sunLightLevel = "";

  //variable to check switches status
  bool isMainSwitchOn = false;
  bool isFertilizerSwitchOn = false;
  bool isWateringSwitchOn = false;

  //variables to call database and authentication
  final DatabaseServices _db = DatabaseServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //variable to check notification status
  String humidity = '';
  bool isHumiditySet = false;
  bool isRecivedNotificatiion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:systemID.isNotEmpty?FirebaseFirestore.instance
            .collection('EspData')
            .doc(systemID)
            .snapshots():FirebaseFirestore.instance
            .collection('EspData')
            .doc("DHT")
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Handle the case where the document doesn't exist
            return const DefaultHomeScreen();
          }

          var humidity = snapshot.data!.get('Temperature') ?? "0";
            var isHumiditySet = false;
            print("Temprature"+humidity);
            print("System"+systemID);
            isRecivedNotificatiion =
                snapshot.data!.get('SetNotificationStatus') ?? "0";
           if (humidity == '28.00') {
                isHumiditySet = true;
                print(humidity);
              } else {
                isHumiditySet = false;
                if(systemID.isNotEmpty){
                  //print(systemID);
                  _db.ESPCollection
                   .doc(systemID)
                   .update({"SetNotificationStatus": false});
                }
              }
              String notificationTitle = "Humidity Notification";
              String notificationMessage = "Please on the watering switch";
              DateTime currentDateTime = DateTime.now();
              String receviedDateTime = currentDateTime.toString();
              // if (isHumiditySet && !isRecivedNotificatiion) {

              // }

              if (isHumiditySet && !isRecivedNotificatiion) {
                LocalNotification().showSimpleNotification(
                    title: notificationTitle,
                    body: notificationMessage,
                    payload: "This is simple data");
                _db.setNotification(receviedDateTime, _auth.currentUser!.uid,
                    notificationTitle, notificationMessage, receviedDateTime);
                if(systemID.isNotEmpty){
                   print("notification come");
                   _db.ESPCollection
                    .doc(systemID)
                    .update({"SetNotificationStatus": true});
                }
              } else {}

          return SafeArea(
            child: Stack(
              children: [
                Opacity(
                  opacity: isMenuBarClicked ? 0.6 : 1.0,
                  child: Container(
                    width: 375.w,
                    height: 812.h,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF4553C6),
                          Color(0xFF5178F1),
                        ],
                      ),
                    ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 48.h,
                              width: 329.w,
                              margin: EdgeInsets.only(top: 0.h),
                              child: TopMenu(
                                  isMenuClickedValue: (value) {
                                    setState(() {
                                      isMenuBarClicked = value;
                                    });
                                  },
                                  isClicked: isMenuBarClicked),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Container(
                                height: 28.h,
                                width: 329.w,
                                child: TempCloudTools(
                                  isClicked: isTempratureClicked,
                                  isClickedValueOn: (value) {
                                    setState(() {
                                      isTempratureClicked = value;
                                    });
                                  },
                                  temprature: temprature,
                                  isToolOn: isTempToolOn,
                                  cloud_status: cloudStatus,
                                )),
                            SizedBox(
                              height: 9.h,
                            ),
                            //begining of the calender and weather tools part
                            Container(
                              height: 143.h,
                              width: 329.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                                color: const Color(0xFF5178F1),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Calender(), //calender part
                                  SizedBox(
                                    height: 23.h,
                                  ),
                                  //Beginning of the weather tools part
                                  Container(
                                    height: 45.h,
                                    width: 300.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        WeatherToolMaintain(
                                          bgclr: const Color(0xFFFFDC30),
                                          img: 'images/home/light.png',
                                          txt1: "Light",
                                          txt2: "$sunLightLevel K",
                                          isClickedValue: (value) {
                                            setState(() {
                                              isLightClicked = value;
                                            });
                                          },
                                          isClicked: isLightClicked,
                                          isToolOn: isLightToolOn,
                                        ),
                                        WeatherToolMaintain(
                                          bgclr: const Color(0xFF9BEC79),
                                          img: 'images/home/wind.png',
                                          txt1: "Wind",
                                          txt2: '$windSpeed m/',
                                          isClickedValue: (value) {
                                            setState(() {
                                              isWindClicked = value;
                                            });
                                          },
                                          isClicked: isWindClicked,
                                          isToolOn: isWindToolOn,
                                        ),
                                        WeatherToolMaintain(
                                          bgclr: const Color(0xFFACDBFF),
                                          img: 'images/home/humidity.png',
                                          txt1: "Humidity",
                                          txt2: '$humidityE %',
                                          isClickedValue: (value) {
                                            setState(() {
                                              isHumidityClicked = value;
                                            });
                                          },
                                          isClicked: isHumidityClicked,
                                          isToolOn: isHumidityToolOn,
                                        ),
                                      ],
                                    ),
                                    //end of the weather tools part
                                  ),
                                ],
                              ),
                            ),
                            //end of the calender and weather tools part
                            SizedBox(
                              height: 22.h,
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            //begininng of the main switch
                            Container(
                              width: 329.w,
                              height: 165.h,
                              child: MainSwitch(
                                isMainSwitchOn: isMainSwitchOn,
                                isMainSwitchOnValue: (value) {
                                  setState(() {
                                    isMainSwitchOn = value;
                                  });
                                },
                                isWateringSwitchOn: isWateringSwitchOn,
                                isWateringSwitchOnValue: (value) {
                                  setState(() {
                                    isWateringSwitchOn = value;
                                  });
                                },
                                isFertilizerSwitchOn: isFertilizerSwitchOn,
                                isFertilizerSwitchOnValue: (value) {
                                  setState(() {
                                    isFertilizerSwitchOn = value;
                                  });
                                },
                              ),
                            ),
                            //end of the main switch
                            SizedBox(
                              height: 30.h,
                            ),
                            //Begining of the fertilizer switch
                            SystemSwitch(
                                isMainSwitchOn: isMainSwitchOn,
                                isSwitchOn: isFertilizerSwitchOn,
                                isSwitchOnValue: (value) {
                                  setState(() {
                                    isFertilizerSwitchOn = value;
                                  });
                                },
                                systemType: "Fertilizer"),
                            //End of the fertilizer switch
                            SizedBox(
                              height: 14.h,
                            ),
                            //Begining of the watering switch
                            SystemSwitch(
                                isMainSwitchOn: isMainSwitchOn,
                                isSwitchOn: isWateringSwitchOn,
                                isSwitchOnValue: (value) {
                                  setState(() {
                                    isWateringSwitchOn = value;
                                  });
                                },
                                systemType: "Watering"),
                            //end of the watering switch
                            SizedBox(
                              height: 20.h,
                            ),
                            //status list
                            const StatusLevelList(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //navigation menu of the home
                NavBar(
                  isMenuBarClicked: isMenuBarClicked,
                  isMenuBarClickedValue: (value) {
                    setState(() {
                      isMenuBarClicked = value;
                    });
                  },
                ),
                //temprature and cloud status set tool
                WeatherToolType01(
                  isClicked: isTempratureClicked,
                  isSwitchOn: isTempToolOn,
                  isSwitchOnValue: (value) {
                    setState(() {
                      isTempToolOn = value;
                    });
                  },
                ),
                //light status set tool
                WheatherTool(
                    isClicked: isLightClicked,
                    isToolOn: isLightToolOn,
                    isToolOnValue: (value) {
                      setState(() {
                        isLightToolOn = value;
                      });
                    },
                    left: 14.w,
                    clr: const Color(0xFFFFDC30),
                    img: Image(
                      image: const AssetImage('images/home/light (2).png'),
                      height: 53.h,
                      width: 44.w,
                    ),
                    statusType: 'Light Status'),
                //wind speed set tool
                WheatherTool(
                    isClicked: isWindClicked,
                    isToolOn: isWindToolOn,
                    isToolOnValue: (value) {
                      setState(() {
                        isWindToolOn = value;
                      });
                    },
                    left: 114.w,
                    clr: const Color(0xFF9BEC79),
                    img: Image(
                      image: const AssetImage('images/home/wind (2).png'),
                      height: 53.h,
                      width: 44.w,
                    ),
                    statusType: 'Wind Status'),
                //humidity status set tool
                WheatherTool(
                    isClicked: isHumidityClicked,
                    isToolOn: isHumidityToolOn,
                    isToolOnValue: (value) {
                      setState(() {
                        isHumidityToolOn = value;
                        setWeatherDetails();
                      });
                    },
                    left: 192.w,
                    clr: const Color(0xFFACDBFF),
                    img: Image(
                      image: const AssetImage('images/home/humidity (2).png'),
                      height: 53.h,
                      width: 44.w,
                    ),
                    statusType: 'Humidity Status'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> setWeatherDetails() async {
    final WeatherService wservice =
        WeatherService('17616021dbc6c5abe5bb6d8029d52b99');
    String uid =
        isGmailUser || isFacebookUser ? _auth.currentUser!.uid : emailUID;
    DocumentSnapshot? documentSnapshot = await _db.getLocation(uid);
    print(documentSnapshot);

    if (documentSnapshot != null && documentSnapshot.exists) {
      String latitude = documentSnapshot["Latitude"];
      String longitude = documentSnapshot["Longitude"];
      print(longitude + "" + latitude);

      try {
        Map<String, dynamic>? weatherData =
            await wservice.getWeather(latitude, longitude);

        setState(() {
          cloudStatus = '${weatherData?['clouds']['all']}';
          temprature =
              '${(weatherData?['main']['temp'] - 273.15).toStringAsFixed(2)}';
          humidityE = '${weatherData?['main']['humidity']}';
          windSpeed = '${weatherData?['wind']['speed']}';
          int sunRiseTime = weatherData?['sys']['sunrise'];
          int sunSetTime = weatherData?['sys']['sunset'];

          calculateSinligtLevel(sunRiseTime, sunSetTime);
          print("sunlightlevel $sunLightLevel");
        });
      } catch (e) {
        // Handle any errors that occur during weather data retrieval
      }
    } else {
      // Handle the case where the documentSnapshot is null or does not exist
    }
  }

  void calculateSinligtLevel(int sunRiseTime, int sunSetTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int sunriseTime = sunRiseTime;
    int sunsetTime = sunSetTime;

    // Calculate the daylight duration
    int daylightDuration = sunsetTime - sunriseTime;

    // Calculate the current time in daylight
    int currentTimeInDaylight = currentTime - sunriseTime;

    // Calculate the sunlight level as a percentage
    double sunlightLevel = ((currentTimeInDaylight / daylightDuration) * 100);
    sunLightLevel = sunlightLevel.toStringAsFixed(2).substring(0, 1);
    print(sunLightLevel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWeatherDetails();
  }
}
