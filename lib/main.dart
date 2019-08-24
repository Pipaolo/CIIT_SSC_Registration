import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroPage.dart';
import 'SectionPage.dart';

void main() {
  runApp(MaterialApp(
    title: "Intro",

    initialRoute: "/",
    routes: {
      '/': (context) => IntroPage(),
      '/SectionPage': (context) => SectionPage(),
      '/InputPage': (context) => IntroPage()
    },
  ));
}


