import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ssc_registration/LineDrawer.dart';

import 'GroupPage.dart';
import 'InputPage.dart';
import 'IntroPage.dart';
import 'StudentModel.dart';

class SectionPage extends StatefulWidget {
  static const routeName = "/SectionPage";

  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  @override
  Widget build(BuildContext context) {
    final Student _student = ModalRoute
        .of(context)
        .settings
        .arguments;
    var sections = generateSectionList(_student.isGrade11);
    return MaterialApp(
      routes: {
        '/IntroPage': (context) => IntroPage(),
        '/SectionPage': (context) => SectionPage(),
        '/InputPage': (context) => InputPage(),
        '/GroupPage': (context) => GroupPage()
      },
      theme: ThemeData(fontFamily: 'Gotham'),
      title: "Section Page",
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 51, 76),
        appBar: AppBar(
          leading: IconButton(icon: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text("Choose your Section"),
          centerTitle: true,
        ),
        body: CustomPaint(
          painter: LineDrawer(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return Center(
                        child: Card(
                          color: Colors.blueAccent.withAlpha(230),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              Navigator.pushNamed(context, InputPage.routeName,
                                  arguments: Student(
                                      sections[position], "",
                                      _student.isGrade11
                                  ));
                            },
                            child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    sections[position],
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      );
                    },
                    itemCount: sections.length,
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List generateSectionList(isGrade11){
    var grade11Sections = ["Python", "Pattern", "Hue", "Symmetry", "Unity", "Vision"];
    var grade12Sections = ["Java", "Rhythm", "Harmony", "Balance", "Texture", "Maya", "Max"];

    return (isGrade11) ? grade11Sections : grade12Sections;
  }
}