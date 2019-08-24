import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';

import 'InputPage.dart';

class SectionPage extends StatefulWidget {
  final bool isGrade11;

  const SectionPage({Key key, this.isGrade11}) : super(key: key);@override

  _SectionPageState createState() => _SectionPageState(isGrade11);
}

class _SectionPageState extends State<SectionPage> {
  final bool isGrade11;

  _SectionPageState(this.isGrade11);

  @override
  Widget build(BuildContext context) {
    var sections = generateSectionList(isGrade11);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_back_ios : Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text("Choose a Section"),
          centerTitle: true,
        ),
        body: Container(
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
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage(section: sections[position], isGrade11: isGrade11,)));
                          },
                          child: Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  sections[position],
                                  style: TextStyle(fontSize: 40),
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
    );
  }
  List generateSectionList(isGrade11){
    var grade11Sections = ["Python", "Pattern", "Hue", "Symmetry", "Unity", "Vision"];
    var grade12Sections = ["Java", "Rhythm", "Harmony", "Balance", "Texture", "Maya", "Max"];

    return (isGrade11) ? grade11Sections : grade12Sections;
  }
}