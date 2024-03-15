import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: notiscreen(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    ),
  );
}

class notiscreen extends StatefulWidget {
  @override
  _notiscreenState createState() => _notiscreenState();
}

class _notiscreenState extends State<notiscreen> {
  int notificationsSettings = 63;
  bool mobile = false;

  double get descriptionFontSize {
    return mobile ? 13 : 15;
  }

  double get titleFontSize {
    return mobile ? 17 : 19;
  }

  @override
  Widget build(BuildContext context) {
    mobile = (MediaQuery.of(context).size.width < 750);
    return Scaffold(
      backgroundColor: Colors.blue, // Background color blue
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: PenConfig.minW, maxWidth: PenConfig.maxW),
            child: Container(
              padding: EdgeInsets.all(PenConfig.padding),
              margin: EdgeInsets.all(PenConfig.padding),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(PenConfig.radius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center, // Align the Column to center
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align the Row to start
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.white), // Icon
                      SizedBox(width: 5), // Space between icon and text
                      SelectableText(
                        PenData.title,
                        style: TextStyle(fontSize: titleFontSize + 2, fontWeight: FontWeight.bold, color: PenColors.title),
                      ),
                    ],
                  ),
                  SizedBox(height: PenConfig.gap),
                  ...PenData.items.map((e) {
                    return Container(
                      padding: EdgeInsets.all(PenConfig.gap),
                      margin: EdgeInsets.only(top: PenConfig.gap / 2, bottom: PenConfig.gap / 2),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(11, 93, 186, 1),
                        borderRadius: BorderRadius.all(Radius.circular(PenConfig.radius)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          SizedBox(width: PenConfig.gap),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SelectableText(e['title'], style: TextStyle(fontSize: titleFontSize, color: PenColors.title)),
                                SizedBox(height: PenConfig.gap / 4),
                                Text(e['description'], style: TextStyle(fontSize: descriptionFontSize, color: PenColors.description)),
                              ],
                            ),
                          ),
                          Text(
                            '1 hours',
                            style: TextStyle(fontSize: 15, color: PenColors.title),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  SizedBox(height: PenConfig.gap),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PenColors {
  static const Color scaffold = Color(0xFF1a1b1d);
  static const Color card = Color(0xFF31333c);
  static const Color item = Color(0xFF474a57);
  static const Color title = Colors.white; // Changed title color to white
  static const Color description = Colors.white;
  static const Color green = Color(0xFF81ce78);
  static const Color grey = Color(0xFF9a9cab);
}

class PenData {
  static const String title = 'Notifications';

  static const List<Map<String, dynamic>> items = [
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 1,
    },
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 2,
    },
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 4,
    },
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 8,
    },
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 16,
    },
    {
      'title': 'Sample text',
      'description': 'Add your own text',
      'value': 32,
    },
  ];
}

class PenConfig {
  static const double minW = 445.0;
  static const double maxW = 1115.0;
  static const double padding = 18.0;
  static const double gap = 12.0;
  static const double radius = 24;
}
