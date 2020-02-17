import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
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

class Reflect extends StatefulWidget {
  final MainModel model;

  Reflect(this.model);

  @override
  _ReflectState createState() => _ReflectState();
}

class _ReflectState extends State<Reflect> with SingleTickerProviderStateMixin {
//  ScrollController _controller = new ScrollController();
//  final GlobalKey _menuKey = new GlobalKey();
  TabController _controller;

  @override
  void initState() {
    super.initState();
    print('fetch News');
    widget.model.fetchReflects();
//    _controller = new TabController(length: 2, vsync: this);
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
        if (model.allReflects.length == 0) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: model.allReflects.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title: Text(
                            model.allReflects[Index].title,
                            style: TextStyle(fontFamily: 'opensans'),
                          ),
                          subtitle: Padding(
                            child: Text(
                              model.allReflects[Index].description,
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
            'REFLECT',
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

        body: new Stack(
//        shrinkWrap: true,

          children: <Widget>[
            new Container(
//                      height:120.0,
              margin: EdgeInsets.only(top: 60.0),
//                      padding: EdgeInsets.all(20),
              child: _buildNewsList(),
            ),

            new Container(
                decoration: new BoxDecoration(
                  color: hexToColor("#3A3171"),
                  border: Border(
                      bottom: BorderSide(
                    color: hexToColor('#3A3171'),
                  )),
                ),
                padding: EdgeInsets.fromLTRB(30, 5, 0, 5),
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      color: hexToColor('#3A3171'),
//                              textColor: Colors.white,
//                              elevation: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: new Text(
                            '20-August-2019',
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

//            new Container(
//              padding:EdgeInsets.fromLTRB(25.0,0,25,0) ,
//              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
//              decoration: new BoxDecoration(color: hexToColor("#ffffff") ,
//                border: Border(bottom: BorderSide(color: hexToColor('#eeeeee') , width: 1.2)),
//              ),
//              child: new TabBar(
//                controller: _controller,
//
//                labelColor: hexToColor('#3A3171'),
//                indicatorColor: hexToColor('#3A3171'),
//                unselectedLabelColor: hexToColor('#333333'),
//
//                tabs: [
//                  new Tab(
//                    text: 'News',
//
//                  ),
//                  new Tab(
//                    text: 'Events',
//                  ),
//                ],
//              ),
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
