import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssc_registration/LineDrawer.dart';
import 'package:ssc_registration/StudentModel.dart';

import 'GroupPage.dart';
import 'InputPage.dart';
import 'SectionPage.dart';

class IntroPage extends StatefulWidget {
  static const routeName = "/IntroPage";

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    var sections = ["Grade \n11", "Grade \n12"];

    return MaterialApp(
      routes: {
        '/IntroPage': (context) => IntroPage(),
        '/SectionPage': (context) => SectionPage(),
        '/InputPage': (context) => InputPage(),
        '/GroupPage': (context) => GroupPage()
      },
      theme: ThemeData(fontFamily: 'Gotham'),
      title: "Intro Page",
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 51, 76),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Grade Level"),
          centerTitle: true,
        ),
        body: CustomPaint(
          painter: LineDrawer(),
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, position) {
                        return Center(
                          child: Card(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SectionPage.routeName,
                                    arguments: Student(
                                        "", "",
                                        (sections[position] == "Grade \n11")
                                            ? true
                                            : false));
                              },
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    sections[position],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 40),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: sections.length,
                      shrinkWrap: true,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
