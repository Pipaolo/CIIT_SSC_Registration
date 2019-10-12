import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssc_registration/StudentModel.dart';

import 'GroupPage.dart';
import 'InputPage.dart';
import 'LineDrawer.dart';
import 'SectionPage.dart';

class IntroPage extends StatelessWidget {
  static const routeName = "/IntroPage";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/IntroPage': (context) => IntroPage(),
          '/SectionPage': (context) => SectionPage(),
          '/InputPage': (context) => InputPage(),
          '/GroupPage': (context) => GroupPage()
        },
        theme: ThemeData(fontFamily: 'Gotham'),
        title: "Intro Page",
        home: _IntroPage());
  }
}

class _IntroPage extends StatefulWidget {
  @override
  __IntroPageState createState() => __IntroPageState();
}

class __IntroPageState extends State<_IntroPage> {
  var sections = ["11", "12"];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                Flexible(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return Center(
                        child: Card(
                          color: Colors.blueAccent,
                          margin: EdgeInsets.only(
                              top: _width * 0.05,
                              left: _width * 0.02,
                              right: _width * 0.02,
                              bottom: _width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SectionPage.routeName,
                                  arguments: Student(
                                      "",
                                      "",
                                      (sections[position] == "11")
                                          ? true
                                          : false));
                            },
                            child: Center(
                                child: Text(
                                  sections[position],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 60,
                                      color: Colors.white.withAlpha(200)),
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
    );
  }
}
