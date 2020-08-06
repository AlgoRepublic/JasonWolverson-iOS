import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
//import 'package:zendesk/zendesk.dart';

const ZendeskAccountKey = 'RdBLm5TXAvIEoe8No20HpkHT03JzhhQM';

class MyAppChat extends StatefulWidget {
  @override
  _MyAppChatState createState() => new _MyAppChatState();
}

class _MyAppChatState extends State<MyAppChat> {
//  String _platformVersion = 'Unknown';
//  final Zendesk zendesk = Zendesk();

  @override
  void initState() {
    super.initState();
//    initZendesk();
  }

  // Zendesk is asynchronous, so we initialize in an async method.
//  Future<void> initZendesk() async {
//    zendesk.init(ZendeskAccountKey, department: 'Department Name', appName: 'My Example App').then((r) {
//      print('init finished');
//    }).catchError((e) {
//      print('failed with error $e');
//    });
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    // But we aren't calling setState, so the above point is rather moot now.
//  }

  void startChat() async {
//    zendesk.startChat().then((r) {
//      print('startChat finished');
//    }).catchError((e) {
//      print('error $e');
//    });
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'Chat',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              RaisedButton(
                child: Text('Set User Info' , style: TextStyle(color: Colors.white),),
                onPressed: () async {
//                  zendesk.setVisitorInfo(
//                    name: 'My Name',
//                    phoneNumber: '323-555-1212',
//                  ).then((r) {
//                    print('setVisitorInfo finished');
//                  }).catchError((e) {
//                    print('error $e');
//                  });
                },
              ),
              RaisedButton(
                child: Text('Start Chat' , style: TextStyle(color: Colors.white),),
                onPressed: () async {

                  Navigator.pushNamed(context, '/chatRoom');

//                  zendesk.startChat().then((r) {
//                    print('startChat finished');
//                  }).catchError((e) {
//                    print('error $e');
//                  });
                },
              ),
          ],
        ),
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
                  Navigator.pushReplacementNamed(context, '/inspiration');
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0),
                    ),
                  ),
                  child: Text(
                    'CHAT',
                    style: TextStyle(
                        color: hexToColor('#ffffff'),
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
                    child: Text(
                      'ABOUT',
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
