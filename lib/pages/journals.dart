import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar/flutter_calendar.dart';

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

class Journal extends StatefulWidget {
  final MainModel model;
  Journal(this.model);

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> with SingleTickerProviderStateMixin {
//  DateTime _currentDate = DateTime(2019, 2, 3);
//  DateTime _currentDate2 = DateTime(2019, 2, 3);
//  TabController _controller;
  DateTime date2;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  @override
  void initState() {
    super.initState();
    print('fetch News');
//    widget.model.fetchJournals();
  }

  Widget _ShowUserInfo() {
//    print('${model.user.email}');
    if (widget.model.user == null) {
      return Text('test@gmail.com');
    } else {
      return Text('${widget.model.user.email}');
    }
  }

  void handleNewDate(date) {
    print("handleNewDate ${date}");
    print('ho');
//    _text();
  }

  Widget _buildNewsList() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.alljournals.length == 0) {
          return Container(
              child: Center(
//                child: CircularProgressIndicator(),
                child: Text('No Journal Found'),
              ));
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: model.alljournals.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(
                            model.alljournals[Index].title,
                            style: TextStyle(fontFamily: 'opensans'),
                          ),
                          subtitle: Padding(
                            child: Text(
                              model.alljournals[Index].description,
                              style: TextStyle(fontFamily: 'opensans'),
                            ),
                            padding: EdgeInsets.fromLTRB(0, 10.0, 0.0, 30.0),
                          )),

//                      MySeparator(color: hexToColor("#3A3171")),
                    ],
                  ));
            });
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
          'JOURNAL',
          style: TextStyle(
              color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'), // POPPING globalContext
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
      //drawer: CustomSideDraw(),
      body: new ListView(
//        shrinkWrap: true,

        children: <Widget>[
//

          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: new Calendar(

//                  onSelectedRangeChange: (range) {
//                    print("Range is ${range.item1}, ${range.item2}");
//                  },
                      onDateSelected: (date) {
                        handleNewDate(date);
                        print('hi');
                        print(date);
                        model.selectDate(date.toString());
                        model.fetchJournals();
                      },
                      isExpandable: true,
                      showTodayAction: false,
                      showCalendarPickerIcon: false),
                );
              }),

          new Container(
//                      height:120.0,
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.all(5),
            child: _buildNewsList(),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/journal_admin');
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: hexToColor('#3A3171'),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
//              InkWell(
//                onTap: () {
//                  Navigator.pushReplacementNamed(context, '/journal_admin');
//                },
//                child: Container(
//                    padding: EdgeInsets.all(15.0),
//                    child: Text(
//                      'Manage Journal',
//                      style: TextStyle(
//                          color: hexToColor('#BCB2C6'),
//                          fontFamily: 'opensans',
//                          fontWeight: FontWeight.w600,
//                          fontSize: 13),
//                    )),
//              ),
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
