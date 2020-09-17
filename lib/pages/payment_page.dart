import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasonw/pages/InAppPurchases/parental_gate.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'InAppPurchases/components.dart';
import 'InAppPurchases/upgrade.dart';

class MonthlyPaymentPage extends StatefulWidget {
  @override
  _MonthlyPaymentPageState createState() => _MonthlyPaymentPageState();
}

class _MonthlyPaymentPageState extends State<MonthlyPaymentPage> {
  final MainModel _model = MainModel();
  // @override
  // Widget build(BuildContext context) {
  //   return  ScopedModel<MainModel>(
  //       model: _model,
  //       child: Scaffold(
  //         backgroundColor: Colors.white,
  //         body: new ListView(
  //           children: <Widget>[
  //             new Container(
  //               color: Colors.white,
  //               //              height: 250,
  //               child: new GridTile(
  //                 child: new Container(
  //                   //                  color: Colors.black,
  //
  //                   child: Image.asset(
  //                     'images/login-img.png',
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //               child: Center(
  //                 child: Text(
  //                   "SUBSCRIPTION",
  //                   style: TextStyle(
  //                       fontSize: 22,
  //                       decoration: TextDecoration.underline,
  //                       color: Color(0Xff594072),
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 30,),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //               child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
  //                 Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
  //                 Text(
  //                   "Monthly Subscription",
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       color: Color(0Xff594072),),
  //                 ),
  //                 SizedBox(height: 20,),
  //                 Text(
  //                   "Charged Monthly",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Color(0Xff594072),),
  //                 ),
  //               ],),
  //                 Column(crossAxisAlignment:CrossAxisAlignment.end,children: [
  //                   Row(children: [
  //                   Container(child: Row(children: [Padding(padding: EdgeInsets.only(top: 5),child: Text("ZAR",style: TextStyle(fontSize: 24,color: Color(0XFF594072),),)),
  //                     Text("199",style: TextStyle(fontSize: 30,color: Color(0XFF594072),),),
  //                       Padding(padding: EdgeInsets.only(bottom: 15),child: Text(".99",style: TextStyle(color: Color(0XFF594072)),))
  //                   ],),)
  //                 ],),
  //                   Align(alignment:Alignment.centerRight,child: Text("/month",style: TextStyle(color: Color(0XFF594072)),))
  //                 ],)
  //               ],)
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(right: 20,top: 10),
  //               child: Align(alignment:Alignment.centerRight,child: Container(width:130,height: 1, color: Color(0XFF594072),),),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
  //               child: RaisedButton(color: Color(0XFF594072),
  //                 child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16),),
  //                 onPressed: () {
  //                   // Navigator.push(
  //                   //   context,
  //                   //   MaterialPageRoute(builder: (context) => PaymentPage()),
  //                   // );
  //                   // _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ));
  // }
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = false;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("kPeTkeMAZMxlilIiQsMVivTjUsDIWddl");

    PurchaserInfo purchaserInfo;
    try {
    purchaserInfo = await Purchases.getPurchaserInfo();
    print(purchaserInfo.toString());
    if (purchaserInfo.entitlements.all['all_features'] != null) {
    appData.isPro = purchaserInfo.entitlements.all['all_features'].isActive;
    } else {
    appData.isPro = false;
    }
    } on PlatformException catch (e) {
    print(e);
    }

    print('#### is user pro? ${appData.isPro}');
  }
  @override
  Widget build(BuildContext context) {
    return TopBarAgnosticNoIcon(
      text: "payment",
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'main',
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  'Welcome',
                  style: kSendButtonTextStyle.copyWith(fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    color: kColorAccent,
                    textColor: kColorText,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Purchase a subscription',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                    onPressed: () {
                      if (appData.isPro) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpgradeScreen(), settings: RouteSettings(name: 'Upgrade screen')));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ParentalGate(), settings: RouteSettings(name: 'Parental Gate')));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
