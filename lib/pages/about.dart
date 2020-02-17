import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
            'About',
            style: TextStyle(
                color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'), // POPPING globalContext
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


            new Container(
              margin: EdgeInsets.only(top: 20.0),
            ),
            new Container(
              decoration: new BoxDecoration(
                color: hexToColor("#ffffff"),
                border: Border(
                    bottom: BorderSide(
                      color: hexToColor('#cccccc'),
                    )),
              ),
              padding: EdgeInsets.fromLTRB(30, 5, 30, 25),
//              margin: EdgeInsets.only(top: 20.0),
              child: GridTile(
                child:new Image.network('https://static.wixstatic.com/media/fe48d2_683204a5741248d6a3601b13c5a24eab~mv2_d_4780_4961_s_4_2.png/v1/fill/w_1820,h_1968,al_c,q_90,usm_0.66_1.00_0.01/fe48d2_683204a5741248d6a3601b13c5a24eab~mv2_d_4780_4961_s_4_2.webp'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              margin: EdgeInsets.only(top: 20.0),
              child:Text(
                  'Jason Wolverson started doing readings at a young age and has evolved his offering into that of a mindful business mentor, often in daily contact with key industry leaders and members of government based in Europe, the America’s, Africa and India.',
                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
                textAlign:TextAlign.justify,

              ),
            ),

            new Container(
              decoration: new BoxDecoration(
                color: hexToColor("#ffffff"),
//
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 35, 0),
              child: GridTile(
                child:new Image.network('https://static.wixstatic.com/media/fe48d2_2d0224c02e0b46828c26d6e0a8f8f488~mv2_d_5669_5669_s_4_2.png/v1/fill/w_1042,h_854,al_c,q_85,usm_0.66_1.00_0.01/fe48d2_2d0224c02e0b46828c26d6e0a8f8f488~mv2_d_5669_5669_s_4_2.webp'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child:Text(
                  'Visionary leaders will quickly realize the benefit of working with Jason on their team, utilizing his ability to read people, situations, clear paths and guide people into the power to make the best choices. Jason is a firm believer in trust and in results, driving people forward to enter a space where they can be the best version of themselves.',
                style:TextStyle(fontSize: 14 , fontFamily: 'anenir', color: hexToColor('#303131')),
                textAlign:TextAlign.justify,
              ),

            ),


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
                onTap: () { Navigator.pushReplacementNamed(context, '/news');},
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
}
