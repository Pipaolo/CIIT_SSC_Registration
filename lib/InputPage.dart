import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:googleapis/sheets/v4.dart' as sheet;
import 'package:googleapis_auth/auth_io.dart';
import 'package:ssc_registration/GroupPage.dart';

import 'IntroPage.dart';
import 'LineDrawer.dart';
import 'SectionPage.dart';
import 'StudentModel.dart';

class InputPage extends StatefulWidget {
  static const routeName = "/InputPage";
  @override
  State createState() => InputPageState();
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  //APP TO SHEETS REQUIREMENTS
  bool _validate = false;

  final accountCredentials = new ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "ciitregistration",
    "private_key_id": "9047f81983bbd27a9582807db3e21ec9da81d3c3",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCkfD0BRkG5LpdK\nsHKAKJBxOItI5PlNKxWOyEUFccSiinQc1nKrSuM/TOdQfNvd7MAlkjaJ/0Y16dPv\n4t4K2py8tMM7vU7yBHH5ckLJ6AxpWdvLI3JS/1J3+8D72ZIFfoqj0bXgTNrqK6Fo\nS+2fQ14P8HGrCmEA24SctI9FUZ3qmKlVatksFvVOkmKPwCPaBYhGVYjeVhIfaKyl\nQnoKY4LvrQNB1KSiQQGkRF98SkP2R8yyYcYS4cZyT77yLhA4OR1orTc8XmIdhxBw\ncrg8JWddkfvEG6LEcXKDMPHyNF4nq51tLzWA+fdztytf2PVoRt3bEdiYFm0u4atR\nbUuZSTdpAgMBAAECggEACG2NOql86J4ohl0wILzzWbnJ+TwyQe/5NM2yK6s+pg1u\nEaQzT++QYUfxekBLi717wvEQ9lUsJcsLXvlC4098RHcGoeL7To9Hv75JCctoB2Xh\nSzFPxEzsztUJeF4Xi0yGkgpGxW1qsiD2Lj/ltwleonZxfJAVlFOrIdRmmuiprMF8\nmekJFpti8D+g/9/0pSVY4UO55w70mihdKuLk/d4PEXa9sbWlsk+kHIdlGlAZWI7N\nNVwrJvtd6xAcLzxgsmKQ/Xj1/V/su8cx1vrH9XMyT0fqWOxOeSdRuwyUWO3gkJUK\n0urrpcSwiXSscUT4ur/qMCmKAPOPYNUh6zRKxLDI2QKBgQDij/nsGk8tfs654Taf\nOvc5Eo1cTb7ZSDpgTBnfFbg7q67d5Irkdy3jyn1nWSApVPMHS8ib65VcplGm88Zj\nFhTZHKVeOaBmocvFbLaRVH9o7zk8W6F4tklFH2C6noEAUVk+1Ihx+T+Jf0gVeOyD\nhm8E92qMWp090D6aS8ifm3l9fwKBgQC522y7siT5splUQBMpDedGT/FnqfzyUFJ8\nSBO52XLx6va9MR8allAStRG1YITZx5cdNk/wbnaUTb5q/P1onYwlzLhzcGA0ObeC\np0ovHuhWXu4Lu4ZBbLSJTWBZD4dXPvKClSn/tDlqSM+bn8OVH9ma+tmZz5MUgTWI\n1tGAKDuPFwKBgQCbIU5VVeZlFnDiYc0O1kc1MvjL/Qfyqzwdd743PB377aA8myJn\nMRug36NiQmp9IoeNtVxVNsf8un0qPbzXV+VKjAzHKdokrCBku/1+IUdkSHj+VReJ\nGfetdsC6x5E48HqVRN1wfOP+d8KZwUThAgm+ctLn65vDGXXkHIPwlXpobQKBgQCw\n8aCxicb+GvUzatVTDrOTE2UnZoU1RRdiz1RIaieu/h3uvSd5roWJae30GnIgzI6n\n9x9gLiqiwul4/mdcBDJ7gk5RSTmuPwzhTNepyOk14acMcHo/K3kuBwalg808WOeV\nPuH/WdwXvj45UX9pKCuKCyzD7QWATgtjvfEy7BrX/QKBgQDeRteP4bgrHzH6L+3d\n/gqSlBgL6qN3oLS9AHFWR/f+p18UbpPMcN9OzQmttatHFoWxLi4jR6k3/limh0LD\nGWBbBE0KIb+W46P8e+Gj6Wn4im3xULI0BlmkaXMU+yrQ9F5PwCgXmpfcQGM4Cg3P\nMx104QGnKiZvoV1jzli42QFC0Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "paolo-toletnino@ciitregistration.iam.gserviceaccount.com",
    "client_id": "109507260530307396305",
  });
  var scopes = const [sheet.SheetsApi.SpreadsheetsScope];

  final grade11SpreadSheetId = "1YS8ry3wiS-KH7NRZHAVdx9rE4Q4ONB8RFzZNDgQXj4g";
  final grade12SpreadsheetId = "1PvkWgV194xbNx-gn1q0_9P1m-MLINazn7ARuCwhI6VA";
  final groupingSpreadsheetId = "1E0B3YRZTezd8wrr8AGU7zBR4-FnbsTzm2SFuMQBkvog";

  //UI Stuff
  final controller = TextEditingController();
  bool isLoading = false;
  var animationController;
  BuildContext scaffoldContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Student _student = ModalRoute
        .of(context)
        .settings
        .arguments;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      routes: {
        '/IntroPage': (context) => IntroPage(),
        '/SectionPage': (context) => SectionPage(),
        '/InputPage': (context) => InputPage(),
        '/GroupPage': (context) => GroupPage()
      },
      title: "Input Page",
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 2, 51, 76),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Theme
                      .of(context)
                      .platform == TargetPlatform.iOS
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back),
                  onPressed: () => Navigator.pop(context)),
              title: Text("Enter Details"),
              centerTitle: true),
          body: Builder(builder: (BuildContext context) {
            scaffoldContext = context;
            return CustomPaint(
              painter: LineDrawer(),
              child: Container(
                height: deviceHeight / 1.2,
                width: deviceWidth,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            controller: controller,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withAlpha(230),
                                focusColor: Colors.amber,
                                labelText: "Name",
                                alignLabelWithHint: false,
                                errorText:
                                _validate ? "Please Enter a Name" : null,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: "Enter Full Name")),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: loadingIcon(
                                  _student.section, _student.isGrade11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  void getCredentials(String name, String section, bool isGrade11) {
    var spreadsheetId = isGrade11 ? grade11SpreadSheetId : grade12SpreadsheetId;
    var studentGroup;
    bool isMatched = false;

    clientViaServiceAccount(accountCredentials, scopes).then((client) {
      sheet.SheetsApi api = new sheet.SheetsApi(client);

      //Get groupings
      api.spreadsheets.values
          .get(groupingSpreadsheetId, "Sheet1!A:S")
          .then((result) {
        print(result);
        int rowNumber = 0;
        bool isNameFound = false;
        for (var row in result.values) {
          rowNumber++;
          int colNumber = 0;
          if (!isNameFound) {
            for (var rowItems in row) {
              colNumber++;
              var tempNameList = name.split(" ");
              var lastName = tempNameList[tempNameList.length - 1];
              if (rowItems.toString().contains(lastName)) {
                isNameFound = !isNameFound;
                if (rowNumber > 12) {
                  studentGroup = "Table ${colNumber + 19}";
                } else {
                  studentGroup = "Table $colNumber";
                }
                break;
              }
            }
          } else {
            break;
          }
        }
      });

      api.spreadsheets.get(spreadsheetId).then((result) {
        for (var sheets in result.sheets) {
          if (sheets.properties.title == section) {
            String range;
            api.spreadsheets.values
                .get(spreadsheetId, "$section")
                .then((result) {
              int i = 0;
              var row = result;
              for (var item in row.values) {
                i++;
                if (item[0] == name) {
                  var vr = sheet.ValueRange.fromJson({
                    "values": [
                      [name, studentGroup, "${item[2]}", "${getTime()}"]
                    ]
                  });
                  print("Found a match!");
                  range = "$section!A$i:D$i";
                  api.spreadsheets.values
                      .update(vr, spreadsheetId, range,
                          valueInputOption: "USER_ENTERED")
                      .then((sheet.UpdateValuesResponse r) {
                    Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                      content: Text(
                        "Time Out Success!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                    ));
                    setState(() {
                      isLoading = !isLoading;
                    });
                  });
                  isMatched = !isMatched;
                  Navigator.pushNamed(
                      context, GroupPage.routeName, arguments: Student(
                      "", "", false));
                }
              }
              if (!isMatched) {
                var vr = sheet.ValueRange.fromJson({
                  "values": [
                    [name, studentGroup, "${getTime()}"]
                  ]
                });
                api.spreadsheets.values
                    .append(vr, spreadsheetId, "$section!A:D",
                        valueInputOption: "USER_ENTERED")
                    .then((sheet.AppendValuesResponse r) {
                  Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                    content: Text(
                      "Welcome $name!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                  ));
                  setState(() {
                    isLoading = !isLoading;
                  });
                  Navigator.pushNamed(
                      context, GroupPage.routeName, arguments: Student(
                      "", studentGroup, false));
                });
              }
            });
          }
        }
      });
    });
    animationController.dispose();
  }

  Widget loadingIcon(String section, bool isGrade11) {
    var submitButton = RaisedButton(
      elevation: 0,
      child: Text(
        "Submit",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.amber.withAlpha(255),
      onPressed: () {
        if (controller.text.isNotEmpty) {
          isLoading = !isLoading;
          setState(() {});
          getCredentials(controller.text, section, isGrade11);
        } else {
          setState(() {
            controller.text.isEmpty ? _validate = true : _validate = false;
          });
        }
      },
    );

    var loading =
    SpinKitCircle(color: Colors.white, controller: animationController);

    return (isLoading) ? loading : submitButton;
  }

  String getTime() {
    String currentTime;
    var militaryHour = DateTime.now().hour;
    var convertedHour;
    var minutes = DateTime.now().minute;

    if (militaryHour > 12 && militaryHour < 24) {
      convertedHour = militaryHour % 12;
      currentTime = "$convertedHour:${minutes}PM";
    } else if (militaryHour / 12 == 2) {
      currentTime = "12:${minutes}AM";
    } else if (militaryHour / 12 == 1) {
      currentTime = "12:${minutes}PM";
    } else {
      currentTime = "$militaryHour:${minutes}AM";
    }
    return currentTime;
  }
}
