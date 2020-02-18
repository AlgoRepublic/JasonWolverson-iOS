//import 'package:braintree_payment/braintree_payment.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasonw/models/productsModel.dart';
import 'package:jasonw/pages/paymentPage.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
//import 'package:html/dom.dart';

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class News extends StatefulWidget {
  final MainModel model;
  final id;
  final title;
  final description;

  News({this.model, this.id, this.title, this.description});

  static const MethodChannel _channel =
      const MethodChannel('braintree_payment');

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {
//  ScrollController _controller = new ScrollController();
//  final GlobalKey _menuKey = new GlobalKey();
  String clientNonce =
      "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZG"
      "ZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0Z"
      "WRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkP"
      "TM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maW"
      "dVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFu"
      "dHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp"
      "7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiw"
      "iZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIs"
      "ImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21"
      "lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2"
      "V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5"
      "icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY"
      "3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlR"
      "W5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaW"
      "RnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUu"
      "Y29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM"
      "6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb2"
      "0iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpc"
      "m9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllb"
      "nQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZ"
      "GJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";

  payNow() async {
    BraintreePayment braintreePayment = new BraintreePayment();
    var data = await braintreePayment.showDropIn(
        nonce: clientNonce,
        inSandbox: true,
        amount: "2.0",
        enableGooglePay: true);
    print("Response of the payment $data");
  }

  showAlertDialog(BuildContext context, int posi) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("event".toUpperCase()),
      content: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white70,
                    child:
                        Text("Cost:", style: TextStyle(fontFamily: 'opensans')),
                  ),
                ),
                Expanded(
                  child: Container(
                    child:
                        Text("110", style: TextStyle(fontFamily: 'opensans')),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
              child: Text("Kindly pay to enroll in the Event",
                  style: TextStyle(
                      fontFamily: 'opensans', color: Colors.blueGrey)),
            ),
            Container()
          ],
        ),
      ),
      actions: [
//        FlatButton(
//          child: Text("CANCEL"),
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//        ),
        FlatButton(
          child: Text("Pay".toUpperCase()),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/paymentPage');
            // setState(() {
            getPaymentUrl(posi); // });

            // Navigator.of(context).pop();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getPaymentUrl(int position) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    String email = sharedPreferences.getString("userEmail");
    String name = "farhat";
    print(token);
    var jsonResponse;
    String url =
        "http://68.183.187.228/api/payfast_url?user_name=$name&email=$email&price=${widget.model.allEvents.elementAt(position).price}&title=${widget.model.allEvents.elementAt(position).title}&event_id=${widget.model.allEvents.elementAt(position).id}&product_id=nill";

    http.Response response = await http.get(url, headers: {
      'Auth-Token': token,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      //   var success = jsonResponse["success"];
      String url = jsonResponse["data"]["url"];
      sharedPreferences.setString("url", url);
      print(url);
      //   print(success);
      //   if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage(url: url,eventId: widget.model.allEvents.elementAt(position).id)),
      );
      //   Navigator.pushReplacementNamed(context, '/paymentPage');
      //   }

      print('test');
    } else if (response.statusCode == 401) {
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      setState(() {});
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }



  interestedForEvent(int position) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print("event");
    Map data = {
      'event_id': widget.model.allEvents.elementAt(position).id,
      'status': "2",
    };
    var jsonResponse;
    http.Response response =
    await http.post("http://68.183.187.228/api/user_event_status",
        headers: {
          'Auth-Token': token,
        },
        body: data);
    if (response.statusCode == 200) {
      setState(() {
//        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
//      sharedPreferences.setString(
//          "eventId", jsonResponse["result"]["event_id"].toString());
      showToast(jsonResponse["message"],
          duration: 4, gravity: Toast.BOTTOM);
//      Navigator.pop(context);
    } else {
      setState(() {
//        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast(jsonResponse["message"], duration: 8, gravity: Toast.BOTTOM);
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

  TabController _controller;

  @override
  void initState() {
    super.initState();
    print('fetch News');
    widget.model.fetchNews();
    widget.model.fetchEvents();
    _controller = new TabController(length: 2, vsync: this);
  }

  Widget _ShowUserInfo() {
//    print('${model.user.email}');
    if (widget.model.user == null) {
      return Text('test@gmail.com');
    } else {
      return Text('${widget.model.user.email}');
    }
  }

  Widget _buildNewsList() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.allNews.length == 0) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: model.allNews.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(
                            model.allNews[Index].title,
                            style: TextStyle(fontFamily: 'opensans'),
                          ),
                          subtitle: Padding(
                            child: Text(
                              model.allNews[Index].description,
                              style: TextStyle(fontFamily: 'opensans'),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 10.0, 0.0, 30.0),
                          )),
                      MySeparator(color: hexToColor("#3A3171")),
                    ],
                  ));
            });
      },
    );
  }

  Widget _buildEventsList() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

//        context: context,
//          position: RelativeRect.fromLTRB(120, 230, 60, 120),
////        position: RelativeRect.fromLTRB(100, 230, 40, 0),
//        items: [
//          PopupMenuItem(
//            child: Text("Going"),
//          ),
//
//          PopupMenuItem(
//            child: Text("Interested"),
//          ),
//          PopupMenuItem(
//            child: Text("Attending"),
//          ),
//        ],

    callMethod(String data) {
      print(data);
    }

    Widget _showPopupMenu(int position) => PopupMenuButton<int>(
          itemBuilder: (context) => [
//          var list = List<PopupMenuEntry<Object>>();
            PopupMenuItem(
              child: Text('Going'),
              value: 1,
            ),
            PopupMenuItem(
              child: Text('Interested'),
              value: 2,
            ),
//            PopupMenuItem(
//              child: Text('Attending'),
//              value :3,
//            ),
          ],
//         initialValue: 2,
//         padding: EdgeInsets.all(20),

          offset: Offset(-90, 220),
          onSelected: (value) {
            print("value:$value");
            print(_ShowUserInfo());

            if (value == 1) {
              //   showAlertDialog(context, position);
              getPaymentUrl(position);
            } else if(value==2){
              interestedForEvent(position);
            }
          },
//          offset: Offset.fromDirection(120 , [20 ] ),
          child: Container(
            height: 35,
            width: 35,
            decoration: new BoxDecoration(
              color: hexToColor("#3A3171"),
              borderRadius: BorderRadius.circular(2.0),
//                              border: new Border.all(
//                                width: 0.0,
//                                color: hexToColor("#3A3171"),
//                              ),
            ),
//         child: Icon(Icons.list),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 17,
            ),
          ),
        );

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.allEvents.length == 0) {
          SizedBox(child: Center(child: Text('loading..')));
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: model.allEvents.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return Container(
                  color: Colors.white,

//                  margin: EdgeInsets.only(top:25.0),
                  padding: EdgeInsets.fromLTRB(0.0, 8, 0, 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Text(
                              model.allEvents[Index].upcoming ? 'Upcoming' : '',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        leading: IconButton(
                          icon: new Image.asset('images/dots.png'),
                          onPressed: () {},
                        ),

                        title: Text(
                          model.allEvents[Index].title,
                          style: TextStyle(fontFamily: 'opensans'),
                        ),
                        subtitle: Text(model.allEvents[Index].scheduled_date),

                        trailing: _showPopupMenu(Index),
//
//                          Container(
//                            height: 35.0,
//                            width: 35.0,
////                            color: Colors.black,
//                            padding: EdgeInsets.all(5.0),
//                            decoration: new BoxDecoration(color: hexToColor("#3A3171") ,
//                              borderRadius: BorderRadius.circular(2.0),
////                              border: new Border.all(
////                                width: 0.0,
////                                color: hexToColor("#3A3171"),
////                              ),
//                            ),
//                            child:IconButton(
//                              padding: new EdgeInsets.all(0.0),
//                              icon: new Icon(Icons.arrow_forward , color: Colors.white, size: 18,),
//                              onPressed: (){
//                                _showPopupMenu();
//                              },
//                             ),
//                          )
                      ),
                      ListTile(
                        subtitle: Padding(
                          child: Text(
                            model.allEvents[Index].description,
                            style: TextStyle(fontFamily: 'opensans'),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 0.0, 20.0, 20.0),
                        ),
                      ),
                      MySeparator(color: hexToColor("#3A3171")),
                    ],
                  ));
            });
//              ],
//            ),

//        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: hexToColor("#ffffff"),
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'NEWS & EVENTS',
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
      body: new Stack(
//        shrinkWrap: true,
        children: <Widget>[
          new Container(
//            height: 500.0,

            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 70.0),
                  child: _buildNewsList(),
                ),
                new Container(
                    margin: EdgeInsets.only(top: 60.0),
                    child: new Stack(
                      children: <Widget>[
                        new Container(
//                      height:120.0,
                          margin: EdgeInsets.only(top: 50.0),
//                      padding: EdgeInsets.all(20),
                          child: _buildEventsList(),
                        ),
                        new Container(
//                        width: 50,
//                        height: 40,
//                      opacity:0.0,
                            decoration: new BoxDecoration(
                              color: hexToColor("#3A3171"),
//                        image: DecorationImage(
//                          image: ExactAssetImage('images/dots.png'),
//                          fit: BoxFit.cover,
//                        ),
                              border: Border(
                                  bottom: BorderSide(
                                color: hexToColor('#3A3171'),
                              )),
                            ),
                            padding: EdgeInsets.fromLTRB(30, 5, 0, 5),
                            margin: EdgeInsets.only(bottom: 40.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  color: hexToColor('#3A3171'),
//                              textColor: Colors.white,
//                              elevation: 0.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                          child: new Text(
                                        '3-August-2019',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontFamily: 'opensans'),
                                      )),
                                      Spacer(),
                                      Expanded(
                                        child: new Icon(Icons.calendar_today,
                                            color: Colors.white, size: 14.0),
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(25.0, 0, 25, 0),
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            decoration: new BoxDecoration(
              color: hexToColor("#ffffff"),
              border: Border(
                  bottom: BorderSide(color: hexToColor('#eeeeee'), width: 1.2)),
            ),
            child: new TabBar(
              controller: _controller,
              labelColor: hexToColor('#3A3171'),
              indicatorColor: hexToColor('#3A3171'),
              unselectedLabelColor: hexToColor('#333333'),
              tabs: [
                new Tab(
                  text: 'News',
                ),
                new Tab(
                  text: 'Events',
                ),
              ],
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

//  payNow() async {
//    String nonve="eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";
//    BraintreePayment braintreePayment = new BraintreePayment();
//    var data = await braintreePayment.showDropIn(
//        nonce: nonve, amount: "2.0",inSandbox: true, enableGooglePay: true);
//    print("Response of the payment $data");
//  }

}
