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
  String humidity = "";
  String windSpeed = "";
  String sunLightLevel = "";

  //variable to check switches status
  bool isMainSwitchOn = false;
  bool isFertilizerSwitchOn = false;
  bool isWateringSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      txt2: '$humidity %',
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
      ),
    );
  }
}
