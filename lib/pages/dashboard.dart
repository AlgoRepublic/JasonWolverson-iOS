import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:jasonw/components/card.dart';
import 'package:jasonw/scoped_models/main.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ChatRoom.dart';
import 'firebase_config.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';


class Dashboard extends StatefulWidget {
  final model;

  Dashboard(this.model);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  PurchaserInfo _purchaserInfo;
  Offerings _offerings;
  String date;
  final _key = UniqueKey();
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  StreamSubscription<String> _onUrlChanged;

//  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool subscribe = false;
  String currentUrl = '';

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    date = formatted;
    currentUrl = 'https://jasonwolverson.algorepublic.com/payfast/subscription?email=${widget.model.user.email}&date=$date';
//    currentUrl = "https://www.google.com.pk";
    super.initState();
    checkSubscription();

//    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//      if (mounted) {
//        if(url == "https://jasonwolverson.algorepublic.com/success"){
//          setState(() {
//            subscribe = true;
//          });
//        }
//
//        print("Current URL: $url");
//      }
//    });
    widget.model.autoAuthenticate();
    print(widget.model.user.email);
    initPlatformState();
    new FirebaseNotifications(widget.model).setUpFirebase();
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
    widget.model.getAllChat();
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => WebViewScreen()),
//    );
  }

  void checkSubscription ()async{
    var  result = await  widget.model.checkSubscription();
    print(result);
    print("in dashboardddddddddddddddddddddddddddddddddd");
    print(result);
       if(result['success'] == true){
         setState(() {
           subscribe = true;
         });
       }
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("DExegcfoiAtRKVYrXGWnkbthKdunHWDr");
    await Purchases.addAttributionData(
        {}, PurchasesAttributionNetwork.facebook);
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatRoom(widget.model)),
      );

  @override
  void dispose() {
//    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return !subscribe
        ? Scaffold(
            body:
            WebView(
              initialUrl:
              currentUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (var url){
                print("URLLL"+url);
                if (url == "https://jasonwolverson.algorepublic.com/success"){
                  setState(() {
                    subscribe = true;
                  });

                }
              },
            )
    )
        : Scaffold(
//      backgroundColor: hexToColor('#f4f5f8'),
            appBar: new AppBar(
              backgroundColor: hexToColor("#3A3171"),
              centerTitle: true,
              elevation: 0.0,
              title: new Text(
                'Smash Life',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'opensans',
                    fontSize: 16.0),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  padding: new EdgeInsets.all(15),
                  child: CardHolder(),
                )
              ],
            ));
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  Widget paymentWidget(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return WebView(
        initialUrl:
            'https://jasonwolverson.algorepublic.com/payfast/subscription?email=${model.user.email}&date=$date',
        javascriptMode: JavascriptMode.unrestricted,
      );
    });
  }
}
