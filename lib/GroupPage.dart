import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssc_registration/LineDrawer.dart';

import 'InputPage.dart';
import 'IntroPage.dart';
import 'SectionPage.dart';
import 'StudentModel.dart';

class GroupPage extends StatefulWidget {
  static const routeName = "/GroupPage";

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    final Student _student = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      routes: {
        '/IntroPage': (context) => IntroPage(),
        '/SectionPage': (context) => SectionPage(),
        '/InputPage': (context) => InputPage(),
        '/GroupPage': (context) => GroupPage()
      },
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 51, 76),
        body: CustomPaint(
          painter: LineDrawer(),
          child: Center(
            child: displayText(_student.group),
          ),
        ),
      ),
    );
  }

  Widget displayText(String studentGroup) {
    if (studentGroup.isEmpty) {
      return Text("Thank you for Coming!\n Take Care!",
          style: TextStyle(fontSize: 50, color: Colors.white),
          textAlign: TextAlign.center);
    } else {
      return Text(
          "Welcome CIITeen! \nEnjoy!!",
          style: TextStyle(fontSize: 50, color: Colors.white),
          textAlign: TextAlign.center);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          IntroPage.routeName, (Route<dynamic> route) => false);
    });
  }
}
