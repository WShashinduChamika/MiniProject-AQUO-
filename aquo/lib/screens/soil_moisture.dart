import 'package:aquo/reusable_widgets/soil_moisture_status_component/sensor_data_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class SoilMoistureLevel extends StatefulWidget {
  const SoilMoistureLevel({super.key});

  @override
  State<SoilMoistureLevel> createState() => _SoilMoistureLevelState();
}

class _SoilMoistureLevelState extends State<SoilMoistureLevel> {
  String selectedValue = 'Daily';
  double maxX = 6;
  List<FlSpot> spots1 = [
    FlSpot(0, 100),
    FlSpot(2, 250),
    FlSpot(4, 300),
    FlSpot(6, 0),
  ];
  List<FlSpot> spots2 = [
    FlSpot(0, 100),
    FlSpot(2, 250),
    FlSpot(4, 300),
    FlSpot(6, 0),
    FlSpot(8, 250),
    FlSpot(10, 300),
    FlSpot(12, 450),
    FlSpot(14, 500),
  ];
  List<FlSpot> spots3 = [
    FlSpot(0, 150),
    FlSpot(2, 350),
    FlSpot(4, 500),
    FlSpot(6, 300),
  ];
  List<FlSpot> spots4 = [
    FlSpot(0, 150),
    FlSpot(2, 350),
    FlSpot(4, 500),
    FlSpot(6, 300),
    FlSpot(8, 450),
    FlSpot(10, 100),
    FlSpot(12, 270),
    FlSpot(14, 380),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 18.h,
              child: Container(
                height: 48.h,
                width: 375.w,
                //color: Colors.amber,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 30.w),
                        child: Image(
                          height: 20.h,
                          width: 10.w,
                          image:
                              AssetImage('images/soil_moisture_level/back.png'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 90.w),
                      child: Text(
                        'Soil moisture',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF272D3B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 72.h,
              left: 13.16.w,
              child: Container(
                height: 324.67.h,
                width: 348.7.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF272D3B).withOpacity(0.2), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 6, // Blur radius
                      offset: Offset(0, 3), // Offset in the x and y directions
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18.9.w, top: 25.h),
                      child: Text(
                        'Soil moisture status',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF272D3B),
                        ),
                      ),
                    ),
                    SensorDataComponent(
                      top: 15.h,
                      leftOfPrecentage: 95.43.w,
                      txt1: 'Water precentage',
                      txt2: '1 month',
                      txt3: '25%',
                    ),
                    SensorDataComponent(
                      top: 13.h,
                      leftOfPrecentage: 164.43.w,
                      txt1: 'Dryness',
                      txt2: 'current',
                      txt3: '30%',
                    ),
                    SensorDataComponent(
                        top: 13.h,
                        leftOfPrecentage: 134.43.w,
                        txt1: 'Temprature',
                        txt2: 'daily',
                        txt3: '16 C'),
                    SensorDataComponent(
                        top: 13.h,
                        leftOfPrecentage: 82.43.w,
                        txt1: 'Average moisture',
                        txt2: 'current',
                        txt3: '35.02'),
                    Container(
                      //alignment: Alignment.center,
                      height: 26.h,
                      width: 26.h,
                      margin: EdgeInsets.only(top: 14.h, left: 300.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFBA58E6),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.r),
                        ),
                      ),
                      child: Image(
                        height: 7.86.h,
                        width: 9.34.w,
                        image:
                            AssetImage('images/soil_moisture_level/arrow.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 406.h,
              left: 13.w,
              child: Container(
                height: 83.h,
                width: 349.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF272D3B).withOpacity(0.2), // Shadow color
                      spreadRadius: 0, // Spread radius
                      blurRadius: 6, // Blur radius
                      offset: Offset(0, 3), // Offset in the x and y directions
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 32.w, top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Graph view',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF272D3B),
                            ),
                          ),
                          Text(
                            'more details',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF272D3B),
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
              top: 427.h,
              left: 170.w,
              child: Theme(
                data: Theme.of(context).copyWith(
                  backgroundColor: Colors.white,
                  focusColor: Color.fromARGB(255, 222, 196, 235),
                  splashColor: Colors.white,
                  canvasColor:
                      Colors.white, // Background color of dropdown menu
                  buttonTheme: ButtonTheme.of(context).copyWith(
                    alignedDropdown: true, // Align dropdown menu to the button
                    //height: 42.h, // Height of the dropdown button
                  ),
                ),
                child: Container(
                  height: 42.h,
                  //width: 154.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFBA58E6),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    underline: Container(color: Colors.white),
                    icon: Container(
                      margin: EdgeInsets.only(left: 73.w),
                      child: Image(
                        image: AssetImage(
                            'images/soil_moisture_level/dropdown.png'),
                      ),
                    ),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                        if (newValue == 'Daily') {
                          maxX = 6;
                        } else if (newValue == 'Weekly') {
                          maxX = 6;
                        } else if (newValue == 'Month') {
                          maxX = 14;
                        }
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text(
                          'Daily',
                          style: TextStyle(
                            color: Color(0xFF272D3B),
                            //color: Color(0xFFBA58E6),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text(
                          'Weekly',
                          style: TextStyle(
                            color: Color(0xFF272D3B),
                            //color: Color(0xFFBA58E6),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Month',
                        child: Text(
                          'Month',
                          style: TextStyle(
                            color: Color(0xFF272D3B),
                            //color: Color(0xFFBA58E6),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '6 months',
                        child: Text(
                          '6 months',
                          style: TextStyle(
                            color: Color(0xFF272D3B),
                            //color: Color(0xFFBA58E6),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Year',
                        child: Text(
                          'Year',
                          style: TextStyle(
                            color: Color(0xFF272D3B),
                            //color: Color(0xFFBA58E6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 530.36.h,
              left: 30.5.w,
              child: Container(
                height: 257.64.h,
                width: 315.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Sensors statistics',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 172,
                      width: 284,
                      margin: EdgeInsets.only(top: 30.h, left: 12.w),
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          //backgroundColor: Color.fromARGB(255, 241, 238, 238),

                          minX: 0,
                          maxX: maxX,
                          minY: 0,
                          maxY: 500,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            horizontalInterval: 1,
                            verticalInterval: 1,
                            getDrawingHorizontalLine: (value) {
                              return const FlLine(
                                color: Colors.white,
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return const FlLine(
                                color: Colors.white,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                interval: 1,
                                getTitlesWidget: bottomTitleWidgets,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                interval: 1,
                                getTitlesWidget: leftTitleWidgets,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),

                          lineBarsData: [
                            LineChartBarData(
                              spots: maxX == 6 ? spots1 : spots2,

                              isCurved: true,
                              barWidth: 0.0,
                              color: Colors.white,
                              //spots: [Colors.blue],
                              dotData: const FlDotData(
                                  show:
                                      false), // Set to true to show dots on each point
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF147AD6),
                                    Color.fromRGBO(20, 122, 214, 1)
                                        .withOpacity(0.11),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            LineChartBarData(
                              spots: maxX == 6 ? spots3 : spots4,

                              isCurved: true,
                              barWidth: 0.0,
                              //spots: [Colors.blue],
                              dotData: const FlDotData(
                                  show:
                                      false), // Set to true to show dots on each point
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFEC6666),
                                    const Color(0xFFEC6666).withOpacity(0.11),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.w),
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  height: 8.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF147AD6),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Sensor 01',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF272D3B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.w),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  height: 8.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEC6666),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Sensor 02',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF272D3B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  bool isWeekly() {
    return maxX == 6 ? true : false;
  }

  bool isMonthly() {
    return maxX == 14 ? true : false;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    DateTime currentDate = DateTime.now();
    String formattedData = DateFormat('MMMM d').format(currentDate);
    DateTime seventhDate = currentDate.add(
      Duration(days: 7),
    );
    String formattedSeventhDate = DateFormat('MMMM d').format(seventhDate);
    //
    String formattedFirstMonth = DateFormat('MMMM').format(currentDate);
    DateTime secondMonth = currentDate.add(
      Duration(days: 30),
    );
    String formattedSecondMonth = DateFormat('MMMM').format(seventhDate);
    var style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.sp,
    );
    Widget text = Text('');

    if (isWeekly()) {
      if (value.toInt() == 0) {
        text = Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text(
              formattedData,
            ));
      } else if (value.toInt() == 6) {
        text = Text(formattedSeventhDate);
      } else {}
    } else if (isMonthly()) {
      if (value.toInt() == 0) {
        text = Padding(
          padding: EdgeInsets.only(left: 75.w),
          child: Text(formattedFirstMonth),
        );
      } else if (value.toInt() == 14) {
        text = Text(formattedSecondMonth);
      } else {}
    } else {
      // Handle the case when isWeekly() is false
      // You might want to assign a different value to the 'text' widget
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12.sp,
      color: Color(0xFF272D3B),
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 249:
        text = '250';
        break;
      case 499:
        text = '500';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
