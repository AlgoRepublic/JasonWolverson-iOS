import 'dart:convert';
import 'dart:ui' as prefix0;

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class SeeMe extends StatefulWidget {
  @override
  _SeeMeState createState() => _SeeMeState();
}

class _SeeMeState extends State<SeeMe> {
  String date, time, dateTime;

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
              icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              })
        ],
      ),
      body: new ListView(
//        shrinkWrap: true,

        children: <Widget>[
//          new Container(
//            padding: EdgeInsets.all(10),
//            child: new Calendar(
//
////                onSelectedRangeChange: (range) {
////                  print("Range is ${range.item1}, ${range.item2}");
////                },
//                onDateSelected: (date) {
//                  print('hi');
//                  print(date);
//                  this.date=date.toString();
//                },
//                isExpandable: true,
//                showTodayAction: false,
//                showCalendarPickerIcon: false),
//          ),

          Container(
            height: MediaQuery.of(context).size.height / 2,
            width:  MediaQuery.of(context).size.width,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
            // initialDateTime: DateTime(DateTime.monthsPerYear),
              onDateTimeChanged: (DateTime newDateTime) {
                String newTod = TimeOfDay.fromDateTime(newDateTime).toString();
                String formattedDate = DateFormat("dd-MM-yyyy hh:mm aa").format(newDateTime);
                print("Formated date $formattedDate");
                this.time = formattedDate;
              },
              use24hFormat: false,
              minuteInterval: 1,
            ),
          ),

          Container(
            height: 40,
            margin: EdgeInsets.only(right: 40,left: 40,top: 10,bottom: 20),
            child: RaisedButton(
              child: Text(
                'Take an oppointment with Jason',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
             //   this.dateTime=this.date +this.time;
                takeAppointment(this.time);

              },
            ),
          )

//            new Container(
////              height: 220,
//              decoration: new BoxDecoration(
//                color: hexToColor("#ffffff"),
//
//              ),
//              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
////              margin: EdgeInsets.only(top: 20.0),
//              child: GridTile(
//                child:new Image.network('https://static.wixstatic.com/media/fe48d2_a29e010f1cc54bb984e92fc1500be7ff~mv2_d_5616_3744_s_4_2.jpg/v1/fill/w_2880,h_950,al_c,q_90,usm_0.66_1.00_0.01/fe48d2_a29e010f1cc54bb984e92fc1500be7ff~mv2_d_5616_3744_s_4_2.webp',
//                fit: BoxFit.fitHeight,
//                ),
//              ),
//            ),
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
//              margin: EdgeInsets.only(top: 20.0),
//              child:Text(
//                "I have been doing this now for 18 years and loving every second. It is an ability that has been passed down in my family line. My daughter will take over from me, just as I've taken over from my mother.",
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//
//              ),
//            ),
//
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                'I have built a powerful career out of helping people and have grown a lot in the process. From an early age I realized I could communicate with people who had crossed over. The joy and healing that it brought to my clients was amazing.',
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
//
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                'I have built a powerful career out of helping people and have grown a lot in the process. From an early age I realized I could communicate with people who had crossed over. The joy and healing that it brought to my clients was amazing.',
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
//
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                'I do regular readings for all kinds of business people and politicians and have helped the police with various missing persons cases. Working on the Leigh Mathews case is what launched that part of my career. I also do regular readings on air for various Radio shows. My book, due to be released later in 2017, details these experiences and more.',
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                "When I was younger my friends and family realized that I was anomalous. I've always shared my  ability with my mom but I seemed to view the world differently still -   talking with spirit, seeing auras and communicating with people that my family couldn't always recognize or see. My mother supported me from the beginning, validating my messages with research and helping me sharpen my ability. I was lucky enough to turn my gift into my career.",
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
//
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                "After two years of working as a psychic medium I was investigated and later scientifically tested and validated by the metaphysical society. I only know of one other medium that allowed himself to be tested, that being Gordon Smith from the UK. I wish everyone in my industry was tested scientifically.",
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
//
//            Container(
//              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
//              child:Text(
//                "I absolutely love what I do and it is a privilege to be able to help. It was communicated to me by spirit as a young child that the word will go from one on one to many and it is amazing to see that dream realised.",
//                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
//                textAlign:TextAlign.justify,
//              ),
//
//            ),
        ],
      ),
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
//                    print('chat press');
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
    http.Response response = await http
        .post("http://68.183.187.228/api/appointments", body: json.encode(data),  headers: {'Auth-Token': token, 'Content-Type': 'application/json'}, );
    if (response.statusCode == 200) {

      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      //showToast(jsonResponse["message"],duration: 4,gravity: Toast.BOTTOM);
      showToast("Your appointment has been submitted to Jason!",gravity: Toast.BOTTOM);

    } else {

      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast(jsonResponse["message"],duration: 4,gravity: Toast.BOTTOM);

    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity,);
  }
}
