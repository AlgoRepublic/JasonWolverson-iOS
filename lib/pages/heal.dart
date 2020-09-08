import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

class Heal extends StatefulWidget {
  @override
  _HealState createState() => _HealState();
}

class _HealState extends State<Heal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String businessName, industry, offer, challenges, noOfEmploy, position;
  final myBusinessNameController = TextEditingController();
  final myofferController = TextEditingController();
  final myPositionController = TextEditingController();
  final myNoOfEmployController = TextEditingController();
  final myChallengesController = TextEditingController();
  final myIndustryController = TextEditingController();
  String createHeelurl = "https://app.jasonwolverson.net/api/heals";
  bool isLoading=false;

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    } else {

      print(noOfEmploy);
      createHeel();
    }
//    Navigator.pushReplacementNamed(context, '/chat');
  }

  createHeel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print(token);
    Map data = {
      'user_id': sharedPreferences.getInt("userId").toString(),
      'business_name': myBusinessNameController.text,
      'industry': myIndustryController.text,
      'what_you_offer': myofferController.text,
      'what_challanges': myChallengesController.text,
      'how_many_employees': myNoOfEmployController.text,
      'position_in_business': myPositionController.text,

    };

    print(data);

    var jsonResponse;
    http.Response response = await http.post(createHeelurl,
        headers: {
          'Auth-Token': token,
        },
        body: data);
    if (response.statusCode == 200) {
      setState(() {
        isLoading= false;
      });
//      jsonResponse = json.decode(response.body);
//      var success = jsonResponse["success"];
//      print(jsonResponse);
//      print(success);
      print(response.body);
      Navigator.pushReplacementNamed(
          context, '/dashboard');
//      sharedPreferences.setString(
//          "eventId", jsonResponse["result"]["event_id"].toString());

//      showToast(" Event Created!", duration: 4, gravity: Toast.BOTTOM);
//      navigateToDashboard();
    } else {
      setState(() {
        isLoading = false;
      });
//      jsonResponse = json.decode(response.body);
//      var success = jsonResponse["success"];

      print(response.body);
//      showToast(jsonResponse["message"], duration: 8, gravity: Toast.BOTTOM);
    }
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
          'Heal',
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
      body: new ListView(
//        shrinkWrap: true,

        children: <Widget>[
          new Form(
            key: _formKey,
            child: new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: new Container(
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 5.0)),
                      new TextFormField(
                        controller: myBusinessNameController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Business name',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {

                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: myIndustryController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Industry',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {

                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: myofferController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'What you offer ',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {

                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: myChallengesController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'What challenges you face  ',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {
                            this.challenges = val;
                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: myNoOfEmployController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'How many employees  ',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {

                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: myPositionController,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText:
                                'What is your position in the business?  ',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),
                        validator: (val) {
                          if (val.length == 0) {

                            return "TextField Cannot be empty";
                          } else {
                            return null;
                          }
                        },


                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new Stack(
                        children: <Widget>[
                          new Visibility(
                         visible: isLoading,
                            child:Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              width: 70.0,
                              height: 70.0,
                              child: new Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: new Center(child: new CircularProgressIndicator())),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                              color: hexToColor("#3A3171"),
                              textColor: Colors.white,
                              elevation: 0.0,
                              height: 52,
                              onPressed: () {
                                setState(() {
                                  isLoading=true;
                                });
                                _submitForm();
                              },
                              child: new Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 14.0, fontFamily: 'opensans'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
}
