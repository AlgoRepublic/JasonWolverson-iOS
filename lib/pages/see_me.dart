import 'dart:convert';
import 'dart:ui' as prefix0;

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeeMe extends StatefulWidget {
  @override
  _SeeMeState createState() => _SeeMeState();
}

class _SeeMeState extends State<SeeMe> {
  String date, time, dateTime;
  bool _isLoading = true;

  final _key = UniqueKey();
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#ffffff"),
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'See Me',
          style: TextStyle(
              color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(
              context, '/dashboard'), // POPPING globalContext
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.home),
              // icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              })
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                  child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                userAgent: "a",
                initialUrl: "https://calendly.com/jason-wolverson/15min",
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    _isLoading = false;
                  });
                },
                onPageStarted: (String url) {
                  print('Page Start loading: $url');
                  _isLoading = true;
                },
              )),
            ],
          ),
          if (_isLoading)
            Container(
              color: Color(0xFF000000).withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    hexToColor('#3A3171'),
                  ),
                ),
              ),
            ),
        ],
      ),
      //  new ListView(
      //   children: <Widget>[
      //     Container(
      //       height: MediaQuery.of(context).size.height / 2,
      //       width: MediaQuery.of(context).size.width,
      //       child: CupertinoDatePicker(
      //         mode: CupertinoDatePickerMode.dateAndTime,
      //         onDateTimeChanged: (DateTime newDateTime) {
      //           String newTod = TimeOfDay.fromDateTime(newDateTime).toString();
      //           String formattedDate =
      //               DateFormat("dd-MM-yyyy hh:mm aa").format(newDateTime);
      //           print("Formated date $formattedDate");
      //           this.time = formattedDate;
      //         },
      //         use24hFormat: false,
      //         minuteInterval: 1,
      //       ),
      //     ),
      //     Container(
      //       height: 40,
      //       margin: EdgeInsets.only(right: 40, left: 40, top: 10, bottom: 20),
      //       child: RaisedButton(
      //         child: Text(
      //           'Take an oppointment with Jason',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         onPressed: () async {
      //           takeAppointment(this.time);
      //         },
      //       ),
      //     )
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: hexToColor('#3A3171'),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/task_list');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 15, 15, 15),
                  child: Text(
                    'DAILY PLAN',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/journal');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'JOURNAL',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/reflect');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'REFLECT',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/inpirations');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'INSPIRATION',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/news');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'HAPPENING',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/chat');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'CHAT',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/seeMe');
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'SEE ME',
                      style: TextStyle(
                          color: hexToColor('#BCB2C6'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/about');
                },
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                          color: hexToColor('#ffffff'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/reflect_admin');
                },
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Manage Reflect',
                      style: TextStyle(
                          color: hexToColor('#BCB2C6'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeAppointment(String time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final Map<String, dynamic> data = {
      'appointment': {
        'appointed_time': time,
      }
    };
    var jsonResponse;
    http.Response response = await http.post(
      "http://68.183.187.228/api/appointments",
      body: json.encode(data),
      headers: {'Auth-Token': token, 'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      //showToast(jsonResponse["message"],duration: 4,gravity: Toast.BOTTOM);
      showToast("Your appointment has been submitted to Jason!",
          gravity: Toast.BOTTOM);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
