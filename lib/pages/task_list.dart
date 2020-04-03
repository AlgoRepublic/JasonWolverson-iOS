import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jasonw/models/WeeklyProgressModel.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../ui_elements/my_divider.dart';
import '../models/bar_graph.dart';
//import '../ui_elements/side_drawer.dart';

class TaskList extends StatefulWidget {
  final MainModel model;

  TaskList(this.model);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>
    with SingleTickerProviderStateMixin {
  WeeklyProgressModel weeklyProgressModel;
  TabController _controller;
  final Map<String, dynamic> _formData = {
    'status': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//  final checkStatus = 'pending';

  @override
  void initState() {

    super.initState();
    widget.model.fetchDailyPlans();
    print('dailyplans');
    widget.model.fetchUserTasks();

    weeklyProgressModel = new WeeklyProgressModel(
        monday: 0,
        tuesday: 0,
        wednesday: 0,
        thursday: 0,
        friday: 0,
        saturday: 0,
        weekly_percentage: 0,
        last_week_percentage: 0);
    getWeeklyrogress();
    _controller = new TabController(length: 3, vsync: this);
  }

  Widget _dailyPlan() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (model.alldailyPlans.length == 0) {
        return Container(
            child: Center(
          child: CircularProgressIndicator(),
//              child: Text('No Daily Plans found'),
        ));
      }

      return ListView.builder(
          shrinkWrap: true,
          itemCount: model.alldailyPlans.length,
//            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1),
          itemBuilder: (BuildContext context, int Index) {
            return Card(
              color: Color.fromARGB(255, 255, 255, 255),
//                  shape: Bo
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
              child: Container(
//                  height: 60,
//                  width: 260,
                child: Column(
                  children: <Widget>[
//                      Text('hi'),
                    ListTile(
                      title: Text(
                        model.alldailyPlans[Index].title,
                        style: TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor('#3A3171')),
                      ),
                      trailing: Text(
                        model.alldailyPlans[Index].time,
                        style: TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor('#3A3171')),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

//Hamza
 List<charts.Series<BarGraph, String>> createSampleData() {

     final data = [
       new BarGraph('Mon', this.weeklyProgressModel.monday),
       new BarGraph('Tue', this.weeklyProgressModel.tuesday),
       new BarGraph('Wed', this.weeklyProgressModel.wednesday),
       new BarGraph('Thur', this.weeklyProgressModel.thursday),
       new BarGraph('Fri', this.weeklyProgressModel.friday),
       new BarGraph('Sat', this.weeklyProgressModel.saturday),
     ];


    return [
      new charts.Series<BarGraph, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#3A3171'),
        domainFn: (BarGraph sales, _) => sales.year,
        measureFn: (BarGraph sales, _) => sales.sales,
        data: data,
        outsideLabelStyleAccessorFn: (BarGraph sales, _) {
          return new charts.TextStyleSpec(
            color: charts.Color.fromHex(code: '#3A3171'),
          );
        },
        insideLabelStyleAccessorFn: (BarGraph sales, _) {
          return new charts.TextStyleSpec(
            color: charts.Color.fromHex(code: '#3A3171'),
          );
        },
      )
    ];
  }

  Widget _weeklyProgress() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();
    final GlobalKey<AnimatedCircularChartState> _chartKey2 =
        new GlobalKey<AnimatedCircularChartState>(); //circular Graph
    //circular Graph
    final Size _chartSize = Size.fromRadius(30.0); //circular Graph

    return ListView(
//      height:500,
      children: <Widget>[
        Column(
          //rcrossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  height: MediaQuery.of(context).size.height * .50,
                  child: new charts.BarChart(

                    createSampleData(),
                    animate: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
//            MySeparator(
//              color: Colors.black,
//            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new AnimatedCircularChart(
                  key: _chartKey,
                  size: _chartSize,
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          weeklyProgressModel.weekly_percentage.toDouble(),
                          hexToColor('#3A3171'),
                          // Colors.deepPurple[400],
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                        100,
                          hexToColor('#CCCCCC'),
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '${weeklyProgressModel.weekly_percentage} % Weekly Percentage',
                  style: TextStyle(color: hexToColor('#3A3171')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new AnimatedCircularChart(
                  key: _chartKey2,
                  size: _chartSize,
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          weeklyProgressModel.last_week_percentage.toDouble(),
                          hexToColor('#3A3171'),
                          //Colors.deepPurple[400],
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          100,
                          hexToColor('#CCCCCC'),
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  edgeStyle: SegmentEdgeStyle.round,
                  percentageValues: true,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('${weeklyProgressModel.last_week_percentage} % Last week Results',
                    style: TextStyle(color: hexToColor('#3A3171'))),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
//            MySeparator(
//              color: Colors.black,
//            ),
          ],
        ),
      ],
    );
  }

  Widget _userTask() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (model.alluserTasks.length == 0) {
        return Container(
            child: Center(
          child: CircularProgressIndicator(),
//              child: Text('No Daily Plans found'),
        ));
      }

      return ListView.builder(
          shrinkWrap: true,
          itemCount: model.alluserTasks.length,
//            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1),
          itemBuilder: (BuildContext context, int Index) {
            return Card(
              color: Color.fromARGB(255, 255, 255, 255),
//                  shape: Bo
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
              child: Container(
//                  height: 60,
//                  width: 260,
                child: Column(
                  children: <Widget>[
//                      Text('hi'),

//                        Container(
//                          child: IconButton(
//                            icon: (checkStatus =='pending' ? Icon(Icons.remove_circle): Icon(Icons.check_circle_outline)),
//                            onPressed: (){
//                             model.selectTask(model.alluserTasks[Index].id);
//                            }
//                          ),
//                        ),

                    ListTile(
                      title: Text(
                        "${model.alluserTasks[Index].title}",
                        style: TextStyle(
                          fontFamily: 'opensans',
                          color: hexToColor('#3A3171'),
                        ),
                      ),

                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          var list = List<PopupMenuEntry<Object>>();
                          list.add(
                            PopupMenuItem(
                              child: Text("Pending"),
                              value: 'Pending',
                            ),
                          );

                          list.add(
                            PopupMenuItem(
                              child: Text("Completed"),
                              value: 'Completed',
                            ),
                          );

                          list.add(
                            PopupMenuItem(
                              child: Text("Cancelled"),
                              value: 'Cancelled',
                            ),
                          );
//                              list.add(
//                                PopupMenuDivider(
//                                  height: 10,
//                                ),
//                              );

                          return list;
                        },
                        onSelected: (value) {
                          print("value:$value");

                          setState(() {
                            _formData['status'] = value;
                          });
//                              _submitForm(
//                                  model.updateUserTasks,
//                                  model.selectUserTask,
//                                  model.selectedTaskIndex,
//                              );
                          model.selectUserTask(
                              model.alluserTasks[Index].UserTaskID);
                          model.selectedTaskIndex;
                          model.updateUserTasks(value);
                        },
                        icon: Icon(
                          model.alluserTasks[Index].status == 'Pending'
                              ? Icons.radio_button_unchecked
                              : model.alluserTasks[Index].status == 'Cancelled'
                                  ? Icons.cancel
                                  :
//                              model.alluserTasks[Index].status=='Completed'?
                                  Icons.check_circle_outline,
                          size: 25,
                          color: hexToColor('#3A3171'),
                        ),
                      ),
//                              _showPopupMenu(),
//                             IconButton(icon: Icon(Icons.check_circle_outline),
//                                 onPressed: (){
//                                    model.selectDailyPlan('${model.alluserTasks[Index].id}');
//                                    model.updateUserTasks();
////                                    print();
//
//
//                                 }
//                             )
//                          Icon(Icons.check_circle_outline , color: hexToColor('#3A3171'),),
//                          Text(model.alluserTasks[Index].status , style: TextStyle(fontFamily: 'opensans', color: hexToColor('#3A3171')),
//
//
//                          ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  void _submitForm(Function updateUserTasks, Function setSelectUserTask,
      [int selectedTaskIndex]) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
//    if (selectedTaskIndex == -1) {
//      updateUserTasks(
//        _formData['status'],
////        _formData['description'],
////        _formData['image'],
////        _formData['price'],
//      ).then((bool success) {
//        if (success) {
//          Navigator
//              .pushReplacementNamed(context, '/')
//              .then((_) => setSelectUserTask(null));
//        } else {
//          showDialog(
//              context: context,
//              builder: (BuildContext context) {
//                return AlertDialog(
//                  title: Text('Something went wrong'),
//                  content: Text('Please try again!'),
//                  actions: <Widget>[
//                    FlatButton(
//                      onPressed: () => Navigator.of(context).pop(),
//                      child: Text('Okay'),
//                    )
//                  ],
//                );
//              });
//        }
//      });
//    }else{
    updateUserTasks(_formData['status']).then((_) {
      return Navigator.pushReplacementNamed(context, '/')
          .then((_) => setSelectUserTask(null));
    });
//    }

//    Map<String, dynamic> successInformation;
//    successInformation =
//    await updateUserTasks(_formData['status']);

//    if (successInformation['success']) {
//      Navigator.pushReplacementNamed(context, '/dashboard');
//    }
//    else {
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text('An Error Occurred!'),
//            content: Text(successInformation['message']),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Okay'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        },
//      );
//    }
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: hexToColor('#ffffff'),
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: new Text(
          'Daily Task',
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
      //drawer: CustomSideDraw(),
      body: new Stack(
        children: <Widget>[
          SizedBox(
            child: Container(
              color: hexToColor("#3A3171"),
              height: 100,
            ),
          ),
          new Container(
//            height:500,
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 45.0),
                  child: _dailyPlan(),
                ),

//                new Container(
//                  margin: EdgeInsets.only(top: 60.0),
//                  child: new Stack(
////                    alignment: Alignment.center,
////                    mainAxisAlignment.center,
//                    children: <Widget>[
//
//                      Positioned(
//                        top:0,
//                        child: new SizedBox(
////                          width: 320,
//                         height: 330,
//                          width: 300,
//                          child: Column(
//                           children: <Widget>[
//                             Expanded(
//                               child: _dailyPlan(),
//                             )
//                           ],
//                         ),
//                        )
//                      ),
//
//
//                    ],
//                  )
//                ),
                new Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(top: 45.0),
                    child: _userTask(),
                  ),
                ),
                //Hamza
                new Container(
                  margin: EdgeInsets.only(top: 45.0),
                  child: _weeklyProgress(),
                ),
//                new Container(
//                  margin: EdgeInsets.only(top: 70.0),
//                  child: new Text('Weekly'),
//                )
              ],
            ),
          ),
          new Container(
//            height:50,
            padding: EdgeInsets.fromLTRB(1.0, 0, 1, 0),
//            height: 40,
            margin: EdgeInsets.fromLTRB(.0, 0.0, 0.0, 10.0),
            decoration: new BoxDecoration(
              color: hexToColor("#3A3171"),
              border: Border(
                  top: BorderSide(color: Colors.white24),
                  bottom: BorderSide(color: Colors.white24)),
//                border: Border(top: BorderSide(color: hexToColor('#eeeeee') , ))
//              border: Border(top: BorderSide(color: hexToColor('#eeeeee') ,
//                  width: 1.2
//              )),
            ),

            child: new TabBar(
              controller: _controller,
              labelColor: hexToColor('#ffffff'),
              indicatorColor: hexToColor('#ffffff'),
              unselectedLabelColor: hexToColor('#BCB2C6'),
              labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'opensans'),
              tabs: [
                new Tab(
                  text: 'Daily Plan',
                ),
                new Tab(
                  text: 'Task List',
                ),
                new Tab(
                  text: 'Weekly Progress',
                ),
//
//                new Tab(
//                  text: 'Weekly Progress',
//                )
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
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 3.0),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 15, 15, 15),
                  child: Text(
                    'DAILY PLAN',
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
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                          color: hexToColor('#BCB2C6'),
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
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/journal_admin');
                },
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Manage Journal',
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

  getWeeklyrogress() async {
    var jsonResponse;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    return http.get(
      'http://68.183.187.228/api/reports/weekly',
      headers: {'Auth-Token': token, 'Content-Type': 'application/json'},
    ).then((http.Response reponse) {
      print("weekly progress");
      print(reponse.body);
      jsonResponse = json.decode(reponse.body);
      print(jsonResponse["report"]["weekly_percentage"]);
      int mond = jsonResponse["report"]["monday"];
      int tuesd = jsonResponse["report"]["tuesday"];
      int wednesd = jsonResponse["report"]["wednesday"];
      int thursd = jsonResponse["report"]["thursday"];
      int frid = jsonResponse["report"]["friday"];
      int saturd = jsonResponse["report"]["saturday"];
      int  weekly_percent = jsonResponse["report"]["weekly_percentage"] ;
      int last_week_percent = jsonResponse["report"]["last_week_percentage"] ;

      print("days");
      print(mond);
      print(tuesd);
      if (!mounted) return;
      setState(() {
        weeklyProgressModel = new WeeklyProgressModel(
            monday: mond,
            tuesday: tuesd,
            wednesday: wednesd,
            thursday: thursd,
            friday: frid,
            saturday: saturd,
            weekly_percentage: weekly_percent,
            last_week_percentage: last_week_percent);

      });


    }).catchError((error) {
      print(error);
    });
  }
}
