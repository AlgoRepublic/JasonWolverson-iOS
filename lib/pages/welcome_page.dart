import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jasonw/pages/InAppPurchases/in_app_purchases_setup.dart';
import 'package:jasonw/pages/dashboard.dart';
import 'package:jasonw/pages/paymentPage.dart';
import 'package:jasonw/pages/payment_page.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/offerings_wrapper.dart';
import 'package:purchases_flutter/purchaser_info_wrapper.dart';
//import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import 'InAppPurchases/components.dart';
import 'InAppPurchases/upgrade.dart';

class WelcomePage extends StatefulWidget {
  final model;

  WelcomePage(this.model);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final MainModel _model = MainModel();
  String text =
      'Jason Wolverson started doing readings at a young age and has evolved his offering into that of a mindful business mentor, often in daily contact with key industry leaders and members of government based in Europe, the America’s, Africa and India.';
  Offerings _offerings;
  PurchaserInfo _purchaserInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    var appDir = (await getTemporaryDirectory()).path;
    new Directory(appDir).delete(recursive: true);
    appData.isPro = false;

    await Purchases.setDebugLogsEnabled(true);
    var deviceId = "";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if ( Platform.isWindows) {
        var deviceData = await deviceInfoPlugin.androidInfo;
        deviceId = deviceData.androidId;
      } else if ( Platform.isIOS) {
        var deviceData = await deviceInfoPlugin.iosInfo;
        deviceId = deviceData.identifierForVendor;
      }
    } on PlatformException {
      print("Failed to get platform");
    }

//    await Purchases.setup("kPeTkeMAZMxlilIiQsMVivTjUsDIWddl",appUserId: "${widget.model.user.email}$deviceId");
    var uuid = Uuid();
// Generate a v1 (time-based) id
    uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
    print("hiid");
    print(uuid);
    Purchases.setup("kPeTkeMAZMxlilIiQsMVivTjUsDIWddl",appUserId: "${widget.model.user.email}$deviceId");

    PurchaserInfo purchaserInfo;
    Purchases.removePurchaserInfoUpdateListener((purchaseListener) { });
//    Purchases.addPurchaserInfoUpdateListener((purchaseListener) { });
    setState(() {
      purchaserInfo = null;
    });
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();

      print("inwelcomePage");

      print(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all.isNotEmpty) {
        appData.isPro = purchaserInfo.entitlements.all['monthly_subscribed_users'].isActive;
      } else {
        appData.isPro = false;
      }
      print(appData.isPro);
    } on PlatformException catch (e) {
      print(e);
    }
    print('#### is user pro? ${appData.isPro}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.white,
            child: new GridTile(
              child: new Container(
                child: Image.asset(
                  'images/login-img.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 26,
                  color: Color(0Xff594072),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'anenir',
                  color: Color(0Xff303131)),
              textAlign: TextAlign.justify,
            ),
          ),
            ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
          return Padding(
            padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
            child: RaisedButton(color: Color(0XFF594072),
              child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16),),
              onPressed: () {
                if (appData.isPro) {
                  return  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard(widget.model)),
                  );
                } else {
                  return
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InAppPurchaseScreen(widget.model),
                          settings: RouteSettings(name: 'Payment Screen'),
                        ));
                }
                // _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
              },
            ),
            );}),
        ],
      ),
    );
  }
}
