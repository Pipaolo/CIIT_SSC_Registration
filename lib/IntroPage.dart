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

  Widget build(BuildContext context) {
    final deviceRotation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 51, 76),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Grade Level"),
        centerTitle: true,
      ),
      body: CustomPaint(
        painter: LineDrawer(),
        child: Column(children: <Widget>[
          generateCards(sections, context, deviceRotation),
        ]),
      ),
    );
  }

  Widget generateCards(
      List sections, BuildContext context, Orientation deviceRotation) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          shrinkWrap: true,
          children: <Widget>[
            GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.05,
                  vertical: deviceHeight * 0.02),
              primary: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (deviceRotation == Orientation.portrait) ? 1 : 2,
                  crossAxisSpacing: 20),
              itemBuilder: (context, position) {
                return Card(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, SectionPage.routeName,
                          arguments: Student("", "",
                              (sections[position] == "11") ? true : false));
                    },
                    child: displayText(
                        sections, position, deviceWidth, deviceRotation),
                  ),
                );
              },
              itemCount: sections.length,
              shrinkWrap: true,
            ),
          ]),
    );
  }

  Widget displayText(List sections, int position, double deviceWidth,
      Orientation deviceRotation) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        sections[position],
        style: TextStyle(
            fontSize: (deviceRotation == Orientation.portrait)
                ? deviceWidth * 0.4
                : deviceWidth * 0.2,
            color: Colors.white.withAlpha(200)),
      ),
    );
  }
}
