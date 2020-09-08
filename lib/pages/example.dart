//import 'package:flutter/material.dart';
//
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//    show CalendarCarousel;
//import 'package:flutter_calendar_carousel/classes/event.dart';
//import 'package:flutter_calendar_carousel/classes/event_list.dart';
//import 'package:intl/intl.dart' show DateFormat;
//import 'package:jasonwolverson/models/journals.dart';
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'dooboolab flutter calendar',
//      theme: new ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: new MyHomePage(title: 'Flutter Calendar Carousel Example'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  DateTime _currentDate = DateTime(2019, 2, 3);
//  DateTime _currentDate2 = DateTime(2019, 2, 3);
//  String _currentMonth = '';
//  final _event_list='';
////  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
//  static Widget _eventIcon = new Container(
//    decoration: new BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(1000)),
//        border: Border.all(color: Colors.blue, width: 2.0)),
//    child: new Icon(
//      Icons.person,
//      color: Colors.amber,
//    ),
//  );
//
//  EventList<Event> _markedDateMap = new EventList<Event>(
//    events: {
//      new DateTime(2019, 2, 10): [
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 1',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 2',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 3',
//          icon: _eventIcon,
//        ),
//      ],
//    },
//  );
//
////  List<Journal> _event_list = [];
//
//  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
//
//  @override
//  void initState() {
//    /// Add more events to _markedDateMap EventList
//    _markedDateMap.add(
//        new DateTime(2019, 2, 25),
//        new Event(
//          date: new DateTime(2019, 2, 25),
//          title: 'Event 5',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.add(
//        new DateTime(2019, 2, 10),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 4',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 1',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 2',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 3',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 4',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 23',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 123',
//        icon: _eventIcon,
//      ),
//    ]);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    /// Example with custom icon
//    _calendarCarousel = CalendarCarousel<Event>(
//      onDayPressed: (DateTime date, List<Event> events) {
//        this.setState(() {
//          return _currentDate = date;
//        });
//         events.forEach((event) {
//          print(event.title);
//        });
//      },
//      weekendTextStyle: TextStyle(
//        color: Colors.red,
//      ),
//      thisMonthDayBorderColor: Colors.grey,
////          weekDays: null, /// for pass null when you do not want to render weekDays
////          headerText: Container( /// Example for rendering custom header
////            child: Text('Custom Header'),
////          ),
////          markedDates: _markedDate,
//      weekFormat: true,
//      markedDatesMap: _markedDateMap,
//      height: 200.0,
//      selectedDateTime: _currentDate2,
////          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
//      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      markedDateShowIcon: true,
//      markedDateIconMaxShown: 2,
//      todayTextStyle: TextStyle(
//        color: Colors.blue,
//      ),
//      markedDateIconBuilder: (event) {
//        return event.icon;
//      },
//      todayBorderColor: Colors.green,
//      markedDateMoreShowTotal:
//      false, // null for not showing hidden events indicator
////          markedDateIconMargin: 9,
////          markedDateIconOffset: 3,
//    );
//
//    /// Example Calendar Carousel without header and custom prev & next button
//    _calendarCarouselNoHeader = CalendarCarousel<Event>(
//      todayBorderColor: Colors.green,
//      onDayPressed: (DateTime date, List<Event> events) {
//        this.setState(() {
//          return _currentDate2 = date;
//        });
//        events.forEach((event) {
//          print(event.title);
//          return  events;
//        });
//      },
//      weekendTextStyle: TextStyle(
//        color: Colors.red,
//      ),
//      thisMonthDayBorderColor: Colors.grey,
//      weekFormat: false,
//      markedDatesMap: _markedDateMap,
//      height: 420.0,
//      selectedDateTime: _currentDate2,
//      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      markedDateShowIcon: true,
//      markedDateIconMaxShown: 2,
//      markedDateMoreShowTotal:
//      false, // null for not showing hidden events indicator
//      showHeader: false,
//      markedDateIconBuilder: (event) {
//        return event.icon;
//      },
//      todayTextStyle: TextStyle(
//        color: Colors.blue,
//      ),
//      todayButtonColor: Colors.yellow,
//      selectedDayTextStyle: TextStyle(
//        color: Colors.yellow,
//      ),
//      minSelectedDate: _currentDate,
//      maxSelectedDate: _currentDate.add(Duration(days: 60)),
////      inactiveDateColor: Colors.black12,
//      onCalendarChanged: (DateTime date) {
//        this.setState(() {
//          return _currentMonth = DateFormat.yMMM().format(date);
//        });
//      },
//    );
//
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text('hi'),
//        ),
//        body: SingleChildScrollView(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              //custom icon
////              Container(
////                margin: EdgeInsets.symmetric(horizontal: 16.0),
////                child: _calendarCarousel,
////              ), // This trailing comma makes auto-formatting nicer for build methods.
//              //custom icon without header
//              Container(
//                margin: EdgeInsets.only(
//                  top: 30.0,
//                  bottom: 16.0,
//                  left: 16.0,
//                  right: 16.0,
//                ),
//                child: new Row(
//                  children: <Widget>[
//                    Expanded(
//                        child: Text(
//                          _currentMonth,
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 24.0,
//                          ),
//                        )),
//                    FlatButton(
//                      child: Text('PREV'),
//                      onPressed: () {
//                        setState(() {
//                          _currentDate2 =
//                              _currentDate2.subtract(Duration(days: 30));
//                          _currentMonth =
//                              DateFormat.yMMM().format(_currentDate2);
//                        });
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('NEXT'),
//                      onPressed: () {
//                        setState(() {
//                          _currentDate2 = _currentDate2.add(Duration(days: 30));
//                          _currentMonth =
//                              DateFormat.yMMM().format(_currentDate2);
//                        });
//                      },
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _calendarCarouselNoHeader,
//              ), //
//            ],
//          ),
//        ));
//  }
//}
//


//
//import 'package:flutter/material.dart';
////import 'package:father_home_flutter/model/constants.dart';
//import 'package:flutter_calendar_carousel/classes/event.dart';
//import 'package:flutter_calendar_carousel/classes/event_list.dart';
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//    show CalendarCarousel;
//
//class ScreenCalendar extends StatefulWidget {
//  @override
//  _ScreenCalendarState createState() => new _ScreenCalendarState();
//}
//
//class _ScreenCalendarState extends State<ScreenCalendar> {
//  static String noEventText = "No event here";
//  String calendarText = noEventText;
//
//  @override
//  void initState() {
//    _markedDateMap.add(
//        new DateTime(2019, 1, 25),
//        new Event(
//          date: new DateTime(2019, 1, 25),
//          title: 'Event 5',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.add(
//        new DateTime(2019, 1, 10),
//        new Event(
//          date: new DateTime(2019, 1, 10),
//          title: 'Event 4',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.addAll(new DateTime(2019, 1, 11), [
//      new Event(
//        date: new DateTime(2019, 1, 11),
//        title: 'Event 1',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 1, 11),
//        title: 'Event 2',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 1, 11),
//        title: 'Event 3',
//        icon: _eventIcon,
//      ),
//    ]);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(
//            'Calender',
////            style: Constants.myTextStyleAppBar,
//          ),
////          iconTheme: Constants.myIconThemeDataAppBar,
////          elevation: Constants.myElevationAppBar,
////          backgroundColor: Constants.myAppBarColor,
//        ),
//        body: SingleChildScrollView(
//            child: Column(children: <Widget>[
//              Card(
//                  child: CalendarCarousel(
//                    weekendTextStyle: TextStyle(
//                      color: Colors.red,
//                    ),
//                    weekFormat: false,
//                    selectedDayBorderColor: Colors.green,
//                    markedDatesMap: _markedDateMap,
//                    selectedDayButtonColor: Colors.green,
//                    selectedDayTextStyle: TextStyle(color: Colors.green),
//                    todayBorderColor: Colors.transparent,
//                    weekdayTextStyle: TextStyle(color: Colors.black),
//                    height: 420.0,
//                    daysHaveCircularBorder: true,
//                    todayButtonColor: Colors.indigo,
//                    locale: 'EN',
//                    onDayPressed: (DateTime date, List<Event> events) {
//                      this.setState(() => refresh(date));
//                    },
//                  )),
//              Card(
//                  child: Container(
//                      child: Padding(
//                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
//                          child: Center(
//                              child: Text(
//                                calendarText,
////                                style: Constants.textStyleCommonText,
//                              )))))
//            ])));
//  }
//
//  void refresh(DateTime date) {
//    print('selected date ' +
//        date.day.toString() +
//        date.month.toString() +
//        date.year.toString() +
//        ' ' +
//        date.toString());
//    if(_markedDateMap.getEvents(new DateTime(date.year, date.month, date.day)).isNotEmpty){
//      calendarText = _markedDateMap.getEvents(new DateTime(date.year, date.month, date.day))[0]
//          .title;
//    } else{
//      calendarText = noEventText;
//    }
//  }
//}
//
//EventList<Event> _markedDateMap = new EventList<Event>(events: {
//  new DateTime(2019, 1, 24): [
//    new Event(
//      date: new DateTime(2019, 1, 24),
//      title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
//          'sed eiusmod tempor incidunt ut labore et dolore magna aliqua.'
//          ' \n\nUt enim ad minim veniam,'
//          ' quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat.'
//          ' \n\nQuis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
//          'Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//      icon: _eventIcon,
//    )
//  ]
//});
//
//Widget _eventIcon = new Container(
//  decoration: new BoxDecoration(
//      color: Colors.white,
//      borderRadius: BorderRadius.all(Radius.circular(1000)),
//      border: Border.all(color: Colors.blue, width: 2.0)),
//  child: new Icon(
//    Icons.person,
//    color: Colors.amber,
//  ),
//);



import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:scoped_model/scoped_model.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

//void main() {
//  initializeDateFormatting().then((_) => runApp(MyApp()));
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Table Calendar Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Table Calendar Demo'),
//    );
//  }
//}

class MyHomePage extends StatefulWidget {
  final MainModel model;
  MyHomePage(this.model);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//  List<Journal> _journals =[];
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleEvents;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    print('theek hia ');
//    widget.model.fetchJournals();
//    print(widget.model.alljournals);
//    _events =  widget.model.fetchJournals().toList();
    _events = {
      DateTime.parse("2019-03-31") : ['Event A6', 'Event B6'],
      DateTime.parse("2019-03-15") : ['Event A7', 'Event B6'],
      DateTime.parse("2019-03-02") : ['Event A6', 'Event B6'],
      DateTime.parse("2019-03-13") : ['Event A6', 'Event B6'],
    };

    Future  getData() async {
      _events = {};
      final response = await http.get("http://muditacenter.com/aplikasi/get_data.php");
      var jsonData = json.decode(response.body);
//      print (jsonData);
      for(var i = 0; i < jsonData.length; i++) {
         _events[DateTime.parse(jsonData[i]['tanggal'])] = jsonData[i]['judul'];
      }
    }
//    _events = getData();
//    print (getData());

    _selectedEvents = _events[_selectedDay] ?? [];
    _visibleEvents = _events;
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');

    setState(() {
      _selectedEvents = events;
      print('hi');
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calender'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('setDay 10-07-2019'),
          onPressed: () {
            _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
}



//import 'dart:async';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:calendar_view_widget/calendar_view_widget.dart';
//import 'package:flutter/material.dart';
////import 'package:jasonwolverson/scoped_models/main.dart';
//import 'package:jasonwolverson/models/journals.dart';
//import 'package:jasonwolverson/models/user.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
////void main() => runApp(new MyApp());
//
////class MyApp extends StatelessWidget {
////  // This widget is the root of your application.
////  @override
////  Widget build(BuildContext context) {
////    return new MaterialApp(
////      title: 'Flutter Demo',
////      theme: new ThemeData(
////        // This is the theme of your application.
////        //
////        // Try running your application with "flutter run". You'll see the
////        // application has a blue toolbar. Then, without quitting the app, try
////        // changing the primarySwatch below to Colors.green and then invoke
////        // "hot reload" (press "r" in the console where you ran "flutter run",
////        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
////        // counter didn't reset back to zero; the application is not restarted.
////        primarySwatch: Colors.blue,
////      ),
////      home: new MyHomePage(title: 'Calendar Widget Example'),
////    );
////  }
////}
//
////class MyHomePage extends StatefulWidget {
//////  MyHomePage({Key key, this.title}) : super(key: key);
//////  final MainModel model;
////  MyHomePage({
//////    this.model,
////    this.title
////});
////
////  // This widget is the home page of your application. It is stateful, meaning
////  // that it has a State object (defined below) that contains fields that affect
////  // how it looks.
////
////  // This class is the configuration for the state. It holds the values (in this
////  // case the title) provided by the parent (in this case the App widget) and
////  // used by the build method of the State. Fields in a Widget subclass are
////  // always marked "final".
////
////  final String title;
////
////  @override
////  _MyHomePageState createState() => new _MyHomePageState();
////}
////
////class _MyHomePageState extends State<MyHomePage> {
//////  Future<Journal> _eventList;
//////  List<Journal> _journals =[];
////  User _authenticatedUser;
////  bool _isLoading = false;
////  StreamController<List<Map<String, String>>> eventsController =
////  new StreamController();
////  List _eventList = [];
////
////
////  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
//////    widget.model.fetchJournals();
//////    alljournals();
//////    print(alljournals);
////
//////    eventList = [
//////      // null location, so location will not be displayed
//////      // but event will be visible in calendar
//////      {
//////        'title': 'Event (null location)',
//////        'description': null,
//////        'issue_date': '2018-09-27 13:27:00',
//////        'id': '1',
//////      },
//////      // null name, so name will not be displayed
//////      // but event will be visible in calendar
//////      {
//////        'title': 'Handle really long names in the event list so it does not break Handle really long names in the event list so it does not break Handle really long names in the event list so it does not break',
//////        'description': 'Suite 501',
//////        'issue_date': '2018-09-21 14:35:00',
//////        'id': '2',
//////      },
//////      // null date, so event below will not be visible in calendar
//////      {
//////        'title': 'Event null date',
//////        'description': '1200 Park Avenue',
//////        'issue_date': null,
//////        'id': '3',
//////      },
//////      // null id, so event below will not be visible in calendar
//////      {
//////        'title': 'Event null id',
//////        'description': 'Grand Ballroom',
//////        'issue_date': '2018-08-27 13:27:00',
//////        'id': null,
//////      },
//////      {
//////        'title': 'Event 4',
//////        'description': 'Grand Ballroom',
//////        'issue_date': '2018-08-27 13:27:00',
//////        'id': '4',
//////      },
//////      {
//////        'title': 'Event 5',
//////        'location': 'Suite 501',
//////        'issue_date': '2018-10-21 14:35:00z',
//////        'id': '5',
//////      },
//////      {
//////        'title': 'Event 6',
//////        'description': '1200 Park Avenue',
//////        'issue_date': '2018-08-22 05:49:00',
//////        'id': '6',
//////      },
//////      {
//////        'title':
//////        'Handle really long names in the event list so it does not break',
//////        'description': '1200 Park Avenue',
//////        'issue_date': '2018-10-24 05:49:00',
//////        'id': '7',
//////      },
//////      {
//////        'title': 'Event 8',
//////        'description':
//////        'Handle really long locations in the event list so it does not break',
//////        'issue_date': '2018-10-24 05:49:00z',
//////        'id': '8',
//////      },
//////    ];
////
//////    print(_eventList);
////
//////    print(_getJournal());
////
////    _eventList = _getJournal() as List<Journal>;
////    print('aaaa tho gye hia ');
////    print(_eventList);
////  }
//////  List<Journals> journals = [];
////
////  Future<List<Journal>> _getJournal() async {
////
////        final SharedPreferences prefs =  await SharedPreferences.getInstance();
////    final String token = prefs.getString('token');
////    if (token!=null){
////      final String userEmail = prefs.getString('userEmail');
////      final String userGender = prefs.getString('userGender');
////      final int userDob = prefs.getInt('userDob');
//////      final String userId = prefs.getString('id');
////      _authenticatedUser = User(email: userEmail,token: token , gender: userGender, date_of_birth: userDob);
////      print(userEmail);
////      print(token);
////      print(userGender);
////      print(userDob);
////
////    }
////
////    var data = await http.get("https://app.jasonwolverson.net/api/journals",
////      headers: {'Auth-Token':_authenticatedUser.token},
////    );
////
////    var jsonData = json.decode(data.body);
////    List<Journal> journals = [];
////
////    final List<Journal> fetchJournalList = [];
////    final Map<String,dynamic> journalListData = jsonDecode(data.body);
////    print(journalListData);
////
//////    for(var u in jsonData){
//////
//////      Journal journal = Journal(u["id"], u["title"], u["description"], u["issue_date"]);
//////
//////      journals.add(journal);
//////
//////    }
////
//////        journalListData.forEach((String journalId, dynamic journalData) {
//////                print('newsssssss');
//////                final Journal journal = Journal(
//////                  id: journalId,
//////                  title: journalData['title'],
//////                  description: journalData['description'],
//////                  issue_date: journalData['issue_date'],
//////                );
//////                print(journal.title);
//////                fetchJournalList.add(journal);
//////
//////        });
////    print(journals.length);
////
////    return journals;
////
////  }
////
//////  List<Journal> get alljournals{
//////    return List.from(_journals);
//////  }
//////
//////  Future<Null> fetchJournal() async {
//////
//////    final SharedPreferences prefs =  await SharedPreferences.getInstance();
//////    final String token = prefs.getString('token');
//////    if (token!=null){
//////      final String userEmail = prefs.getString('userEmail');
//////      final String userGender = prefs.getString('userGender');
//////      final int userDob = prefs.getInt('userDob');
////////      final String userId = prefs.getString('id');
//////      _authenticatedUser = User(email: userEmail,token: token , gender: userGender, date_of_birth: userDob);
//////      print(userEmail);
//////      print(token);
//////      print(userGender);
//////      print(userDob);
//////
//////    }
//////
//////    return http .get('https://app.jasonwolverson.net/api/journals',
//////      headers: {'Auth-Token':_authenticatedUser.token},
//////    )
//////        .then<Null>((http.Response response) {
//////      print(response.body);
//////      final List<Journal> fetchJournalList = [];
//////      final Map<String,dynamic> journalListData = jsonDecode(response.body);
//////      if (journalListData == null) {
//////
//////        _isLoading = false;
////////        notifyListeners();
//////        return;
//////      }
//////
//////      journalListData.forEach((String journalId, dynamic journalData) {
//////        print('newsssssss');
//////        final Journal journal = Journal(
//////          id: journalId,
//////          title: journalData['title'],
//////          description: journalData['description'],
//////
////////          description: newsData['description'],
//////        );
//////        print(journal.description);
//////        fetchJournalList.add(journal);
//////      });
//////      _journals = fetchJournalList;
//////      print('newsssssss');
//////      print(_journals);
//////      _isLoading = false;
////////      notifyListeners();
//////
//////    }).catchError((error) {
//////      _isLoading = false;
////////      notifyListeners();
//////      return;
//////    });
//////
//////
////////    final response =
////////    await http.get('https://app.jasonwolverson.net/api/journals',
////////      headers: {'Auth-Token':_authenticatedUser.token},
////////    );
//////
//////
//////
////////    if (response.statusCode == 200) {
////////      // If the call to the server was successful, parse the JSON.
////////
////////      print(Journal.fromJson(json.decode(response.body)));
////////
////////    } else {
////////      // If that call was not successful, throw an error.
////////      throw Exception('Failed to load post');
////////    }
//////  }
////
////  @override
////  void dispose() {
////    eventsController.close();
////    // TODO: implement dispose
////    super.dispose();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    const eventList = [
////      // null location, so location will not be displayed
////      // but event will be visible in calendar
////      {
////        'title': 'Event (null location)',
////        'description': null,
////        'issue_date': '2018-09-27 13:27:00',
////        'id': '1',
////      },
////      // null name, so name will not be displayed
////      // but event will be visible in calendar
////      {
////        'title': 'Handle really long names in the event list so it does not break Handle really long names in the event list so it does not break Handle really long names in the event list so it does not break',
////        'description': 'Suite 501',
////        'issue_date': '2018-09-21 14:35:00',
////        'id': '2',
////      },
////      // null date, so event below will not be visible in calendar
////      {
////        'title': 'Event null date',
////        'description': '1200 Park Avenue',
////        'issue_date': null,
////        'id': '3',
////      },
////      // null id, so event below will not be visible in calendar
////      {
////        'title': 'Event null id',
////        'description': 'Grand Ballroom',
////        'issue_date': '2018-08-27 13:27:00',
////        'id': null,
////      },
////      {
////        'title': 'Event 4',
////        'description': 'Grand Ballroom',
////        'issue_date': '2018-08-27 13:27:00',
////        'id': '4',
////      },
////      {
////        'title': 'Event 5',
////        'location': 'Suite 501',
////        'issue_date': '2018-10-21 14:35:00z',
////        'id': '5',
////      },
////      {
////        'title': 'Event 6',
////        'description': '1200 Park Avenue',
////        'issue_date': '2018-08-22 05:49:00',
////        'id': '6',
////      },
////      {
////        'title':
////        'Handle really long names in the event list so it does not break',
////        'description': '1200 Park Avenue',
////        'issue_date': '2018-10-24 05:49:00',
////        'id': '7',
////      },
////      {
////        'title': 'Event 8',
////        'description':
////        'Handle really long locations in the event list so it does not break',
////        'issue_date': '2018-10-24 05:49:00z',
////        'id': '8',
////      },
////    ];
////
////    final theme = ThemeData.dark().copyWith(
////      primaryColor: Colors.grey,
////      accentColor: Colors.lightBlue,
////      canvasColor: Colors.white,
////      backgroundColor: Colors.lightBlue,
////      dividerColor: Colors.blueGrey,
////      textTheme: ThemeData.dark().textTheme.copyWith(
////        display1: TextStyle(
////          fontSize: 21.0,
////        ),
////        subhead: TextStyle(
////          fontSize: 14.0,
////          color: Colors.blueGrey,
////        ),
////        headline: TextStyle(
////          fontSize: 18.0,
////          color: Colors.blueGrey,
////          fontWeight: FontWeight.bold,
////        ),
////        title: TextStyle(
////          fontSize: 14.0,
////          color: Colors.blueGrey,
////          fontWeight: FontWeight.bold,
////        ),
////      ),
////      accentTextTheme: ThemeData.dark().accentTextTheme.copyWith(
////        body1: TextStyle(
////          fontSize: 14.0,
////          color: Colors.black,
////        ),
////        title: TextStyle(
////          fontSize: 21.0,
////          color: Colors.black,
////          fontWeight: FontWeight.bold,
////        ),
////        display1: TextStyle(
////          fontSize: 21.0,
////          color: Colors.black,
////          fontWeight: FontWeight.bold,
////        ),
////      ),
////    );
////
////    void onEventTapped(Map<String, String> event) {
////      print(event);
////    }
////
//////    eventsController.add(_eventList);
////
////    // This method is rerun every time setState is called, for instance as done
////    // by the _incrementCounter method above.
////    //
////    // The Flutter framework has been optimized to make rerunning build methods
////    // fast, so that you can just rebuild anything that needs updating rather
////    // than having to individually change instances of widgets.
////    return new Scaffold(
////      appBar: new AppBar(
////        // Here we take the value from the MyHomePage object that was created by
////        // the App.build method, and use it to set our appbar title.
////        title: new Text('ho'),
////      ),
////      body: new Center(
////        // Center is a layout widget. It takes a single child and positions it
////        // in the middle of the parent.
////        child: new Column(
////          // Column is also layout widget. It takes a list of children and
////          // arranges them vertically. By default, it sizes itself to fit its
////          // children horizontally, and tries to be as tall as its parent.
////          //
////          // Invoke "debug paint" (press "p" in the console where you ran
////          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
////          // window in IntelliJ) to see the wireframe for each widget.
////          //
////          // Column has various properties to control how it sizes itself and
////          // how it positions its children. Here we use mainAxisAlignment to
////          // center the children vertically; the main axis here is the vertical
////          // axis because Columns are vertical (the cross axis would be
////          // horizontal).
////          mainAxisAlignment: MainAxisAlignment.center,
////          children: <Widget>[
////            // default String parameter values used below as example
////            new CalendarView(
////              onEventTapped: onEventTapped,
////              titleField: 'title',
////              detailField: 'description',
////              dateField: 'issue_date',
////              separatorTitle: 'Events',
////              theme: theme,
////              eventStream: eventsController.stream,
////            ),
////          ],
////        ),
////      ),
////    );
////  }
////}