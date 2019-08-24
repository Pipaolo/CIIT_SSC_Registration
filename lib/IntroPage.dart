import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SectionPage.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {

    var sections = ["Grade 11", "Grade 12"];

    var grade11Color = Color.fromARGB(255, 233, 59, 50);

    var grade12Color = Color.fromARGB(255, 235, 232, 65);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Choose Section"),
          centerTitle: true,
        ),
        body: Container(
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: (sections[position] == "Grade 11")
                              ? grade11Color
                              : grade12Color,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SectionPage(isGrade11: (sections[position] == "Grade 11") ? true : false)));
                            },
                            child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    sections[position],
                                    style: TextStyle(fontSize: 80),
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
              ]),
        ),
      ),
    );
  }
}