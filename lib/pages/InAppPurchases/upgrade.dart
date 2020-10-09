import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jasonw/Helper/generic_widget.dart';
import 'package:jasonw/pages/InAppPurchases/in_app_purchases_setup.dart';
import 'package:jasonw/pages/dashboard.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/offerings_wrapper.dart';
import 'package:purchases_flutter/package_wrapper.dart';
import 'package:purchases_flutter/purchaser_info_wrapper.dart';
//import 'package:purchases_flutter/purchases_flutter.dart';
import 'components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

PurchaserInfo _purchaserInfo;

class InAppPurchaseScreen extends StatefulWidget {
  final MainModel _model;
  InAppPurchaseScreen(this._model);
  @override
  State<StatefulWidget> createState() => _InAppPurchaseScreenState();
}

class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {
  Offerings _offerings;
  @override
  void initState() {
    super.initState();
    print("innupgradinggggg screeeeeen");
    fetchData();
  }

  Future<void> fetchData() async {
    PurchaserInfo purchaserInfo;
    appData.isPro = false;
    await Purchases.setDebugLogsEnabled(true);
//    await Purchases.setup("kPeTkeMAZMxlilIiQsMVivTjUsDIWddl", appUserId: "${widget._model.user.email}$deviceId");
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();
      print("purchaserInfo");
      print(purchaserInfo);
    } on PlatformException catch (e) {
      print("fetching dataaaaaaa error");
      print(e);
    }

    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print("get offers");
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_purchaserInfo == null) {
      return Scaffold(appBar: AppBar(title: Text("Payment Screen"),backgroundColor: Color(0XFF594072),),
            backgroundColor: kColorPrimary,
            body: Center(
                child: GenericWidget(
                  type: 1,
                ),
            ),);
    } else {
//      if (_purchaserInfo.entitlements.all.isNotEmpty && _purchaserInfo.entitlements.all['monthly_subscribed_users'].isActive != null) {
//        appData.isPro = _purchaserInfo.entitlements.all['monthly_subscribed_users'].isActive;
//      } else {
//        appData.isPro = false;
//      }
//      if (appData.isPro) {
//        return Dashboard(widget._model);
//      } else {
      return UpsellScreen(
        offerings: _offerings,
        model: widget._model,
      );
    }
  }
}

class UpsellScreen extends StatefulWidget {
  final Offerings offerings;
  final MainModel model;

  UpsellScreen({Key key, @required this.offerings, this.model}) : super(key: key);

  @override
  _UpsellScreenState createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  _launchURLWebsite(String zz) async {
    if (await canLaunch(zz)) {
      await launch(zz);
    } else {
      throw 'Could not launch $zz';
    }
  }
  bool _isLoading = false;
  loadingStateChange (){
  setState(() {
  _isLoading = !_isLoading;
  });
    }


  @override
  Widget build(BuildContext context) {
    if (widget.offerings != null) {
      final offering = widget.offerings.current;
      if (offering != null) {
        final monthly = offering.monthly;
        if (monthly != null) {
          return
            Stack(children: [
              Scaffold(appBar: AppBar(title:  Text(
                'Payment Screen',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'opensans',
                    fontSize: 16.0),
              ),backgroundColor: Color(0XFF3A3171),),
                  backgroundColor: kColorPrimary,
                  body: Center(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Thanks for your interest in our app!',
                              textAlign: TextAlign.center,
                              style: kSendButtonTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: CircleAvatar(
                                backgroundColor: kColorPrimary,
                                radius: 45.0,
                                backgroundImage: AssetImage("images/jason-icon.png"),
                              ),
                            ),
                            Text(
                              'Choose our auto-renewable monthly subscription plan to get access of the whole application.\n',
                              textAlign: TextAlign.center,
                              style: kSendButtonTextStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PurchaseButton(package: monthly,model: widget.model,loading: loadingStateChange),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: GestureDetector(
                                onTap: () {
                                  _launchURLWebsite('http://jasonwolverson.algorepublic.com/privacy-policy.html');
                                },
                                child: Text(
                                  'Privacy Policy (click to read)',
                                  style: kSendButtonTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
//                            Padding(
//                              padding: const EdgeInsets.all(18.0),
//                              child: GestureDetector(
//                                onTap: () {
//                                  _launchURLWebsite("https://www.apple.com/legal/internet-services/itunes/dev/stdeula/");
//                                },
//                                child: Text(
//                                  'Term of Use (click to read)',
//                                  style: kSendButtonTextStyle.copyWith(
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.normal,
//                                  ),
//                                ),
//                              ),
//                            ),
                          ],
                        )),
                  )),
              _isLoading
                ? GenericWidget(
              type: 1,
            )
                : Container(),],);
        }
      }
    }
    return TopBarAgnosticNoIcon(
      text: "Upgrade Screen",
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'upgrade_screen1',
      child: Scaffold(
          backgroundColor: kColorPrimary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.error,
                    color: kColorText,
                    size: 44.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "There was an error. Please check that your device is allowed to make purchases and try again. Please contact us at xxx@xxx.com if the problem persists.",
                    textAlign: TextAlign.center,
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class PurchaseButton extends StatefulWidget {
  final Package package;
  final MainModel model ;
  Function loading;

  PurchaseButton({Key key, @required this.package, this.model, this.loading}) : super(key: key);

  @override
  _PurchaseButtonState createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton> {

  PurchaserInfo _purchaserInfo1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        color: kColorPrimaryLight,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: RaisedButton(
                onPressed: () async {
                  widget.loading();
                  print(widget.package);
                  try {
                    print('now trying to purchase');
                    _purchaserInfo1 = await Purchases.getPurchaserInfo();
                    // ignore: unrelated_type_equality_checks
                    print(_purchaserInfo1.entitlements.all.isNotEmpty);
                    print(_purchaserInfo1);
                    if(_purchaserInfo1.entitlements.all.isNotEmpty) {
                      if (_purchaserInfo1.entitlements
                          .all['monthly_subscribed_users'].isActive == true) {
                        Alert(
                          context: context,
                          style: kWelcomeAlertStyle,
                          image: Image.asset(
                            "images/jason-icon.png",
                            height: 150,
                          ),
                          title: "Congratulation",
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,
                                    right: 8.0,
                                    left: 8.0,
                                    bottom: 20.0),
                                child: Text(
                                  'You have already subscribed,and you have full access to the all contents of app ',
                                  textAlign: TextAlign.center,
                                  style: kSendButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                              child: Text(
                                "COOL",
                                style: kSendButtonTextStyle,
                              ),
                              onPressed: () {
                                widget.loading();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                    new Dashboard(widget.model)));
                              },
                              width: 127,
                              color: kColorAccent,
                              height: 52,
                            ),
                          ],
                        ).show();
                      }
                      else {
                        _purchaserInfo =
                        await Purchases.purchasePackage(widget.package);
                        print('purchased complete');
                        print(_purchaserInfo);
                        appData.isPro = _purchaserInfo.entitlements
                            .all["monthly_subscribed_users"].isActive;
                        if (appData.isPro) {
                          Alert(
                            context: context,
                            style: kWelcomeAlertStyle,
                            image: Image.asset(
                              "images/jason-icon.png",
                              height: 150,
                            ),
                            title: "Congratulation",
                            content: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 20.0),
                                  child: Text(
                                    'Well done, you have now full access to all contents of the app',
                                    textAlign: TextAlign.center,
                                    style: kSendButtonTextStyle,
                                  ),
                                )
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                radius: BorderRadius.circular(10),
                                child: Text(
                                  "COOL",
                                  style: kSendButtonTextStyle,
                                ),
                                onPressed: () {
                                  widget.loading();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                      new Dashboard(widget.model)));
                                },
                                width: 127,
                                color: kColorAccent,
                                height: 52,
                              ),
                            ],
                          ).show();
                        }
                        else {
                          Alert(
                            context: context,
                            style: kWelcomeAlertStyle,
                            image: Image.asset(
                              "images/jason-icon.png",
                              height: 150,
                            ),
                            title: "Error",
                            content: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0,
                                      right: 8.0,
                                      left: 8.0,
                                      bottom: 20.0),
                                  child: Text(
                                    'There was an error. Please try again later',
                                    textAlign: TextAlign.center,
                                    style: kSendButtonTextStyle,
                                  ),
                                )
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                radius: BorderRadius.circular(10),
                                child: Text(
                                  "COOL",
                                  style: kSendButtonTextStyle,
                                ),
                                onPressed: () {
                                  widget.loading();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                width: 127,
                                color: kColorAccent,
                                height: 52,
                              ),
                            ],
                          ).show();
                        }
                      }
                    }
                    else {
                      _purchaserInfo = await Purchases.purchasePackage(widget.package);
                      print('purchased complete');
                      appData.isPro = _purchaserInfo.entitlements.all["monthly_subscribed_users"].isActive;
                      if (appData.isPro) {
                        Alert(
                          context: context,
                          style: kWelcomeAlertStyle,
                          image: Image.asset(
                            "images/jason-icon.png",
                            height: 150,
                          ),
                          title: "Congratulation",
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0, bottom: 20.0),
                                child: Text(
                                  'Well done, you have now full access to all contents of the app',
                                  textAlign: TextAlign.center,
                                  style: kSendButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                              child: Text(
                                "COOL",
                                style: kSendButtonTextStyle,
                              ),
                              onPressed: () {
                                widget.loading();
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.of(context, rootNavigator: true).pop();
                                Navigator.push(context, MaterialPageRoute(builder:(context)=> new Dashboard(widget.model) ));
                              },
                              width: 127,
                              color: kColorAccent,
                              height: 52,
                            ),
                          ],
                        ).show();
                      }
                      else {
                        Alert(
                          context: context,
                          style: kWelcomeAlertStyle,
                          image: Image.asset(
                            "images/jason-icon.png",
                            height: 150,
                          ),
                          title: "Error",
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0, bottom: 20.0),
                                child: Text(
                                  'There was an error. Please try again later',
                                  textAlign: TextAlign.center,
                                  style: kSendButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                              child: Text(
                                "COOL",
                                style: kSendButtonTextStyle,
                              ),
                              onPressed: () {
                                widget.loading();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              width: 127,
                              color: kColorAccent,
                              height: 52,
                            ),
                          ],
                        ).show();
                      }
                    }


                  }
                  on PlatformException catch (e) {
                    print("exception");
                    print(e);
                    print(e.message);
                    var errorCode = PurchasesErrorHelper.getErrorCode(e);
                    if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                      print("User cancelled");
                    } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
                      print("User not allowed to purchase");
                    }
                    if(e.message.isNotEmpty){
                      if(e.message == "There is already another active subscriber using the same receipt."){
                        Alert(
                          context: context,
                          style: kWelcomeAlertStyle,
                          image: Image.asset(
                            "images/jason-icon.png",
                            height: 150,
                          ),
                          title: "Congratulation",
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,
                                    right: 8.0,
                                    left: 8.0,
                                    bottom: 20.0),
                                child: Text(
                                'You have already subscribed,and you have full access to the all contents of app ',
                                  textAlign: TextAlign.center,
                                  style: kSendButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                              child: Text(
                                "COOL",
                                style: kSendButtonTextStyle,
                              ),
                              onPressed: () {
                                widget.loading();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                    new Dashboard(widget.model)));
                              },
                              width: 127,
                              color: kColorAccent,
                              height: 52,
                            ),
                          ],
                        ).show();
                      }
                      else
                      if(e.message == "Purchase was cancelled.")
                      {
                        Alert(
                          context: context,
                          style: kWelcomeAlertStyle,
                          image: Image.asset(
                            "images/jason-icon.png",
                            height: 150,
                          ),
                          title: "Error",
                          content: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,
                                    right: 8.0,
                                    left: 8.0,
                                    bottom: 20.0),
                                child: Text(
                                  'There was an error. Please try again later',
                                  textAlign: TextAlign.center,
                                  style: kSendButtonTextStyle,
                                ),
                              )
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                              child: Text(
                                "COOL",
                                style: kSendButtonTextStyle,
                              ),
                              onPressed: () {
                                widget.loading();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              width: 127,
                              color: kColorAccent,
                              height: 52,
                            ),
                          ],
                        ).show();
                      }

                    }
                    else  {
                      Alert(
                        context: context,
                        style: kWelcomeAlertStyle,
                        image: Image.asset(
                          "images/jason-icon.png",
                          height: 150,
                        ),
                        title: "Error",
                        content: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0,
                                  right: 8.0,
                                  left: 8.0,
                                  bottom: 20.0),
                              child: Text(
                                'There was an error. Please try again later',
                                textAlign: TextAlign.center,
                                style: kSendButtonTextStyle,
                              ),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            radius: BorderRadius.circular(10),
                            child: Text(
                              "COOL",
                              style: kSendButtonTextStyle,
                            ),
                            onPressed: () {
                              widget.loading();
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            width: 127,
                            color: kColorAccent,
                            height: 52,
                          ),
                        ],
                      ).show();
                    }

//                    }
                  }
                  return InAppPurchaseScreen(widget.model);
                },
                textColor: kColorText,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Buy Monthly Subscription\n${widget.package.product.priceString}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
              child: Text(
                '${widget.package.product.description}  ',
                textAlign: TextAlign.center,
                style: kSendButtonTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TopBarAgnosticNoIcon(
      text: "Upgrade Screen",
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'pro_screen',
      child: Scaffold(
          backgroundColor: kColorPrimary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.star,
                    color: kColorText,
                    size: 44.0,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "You are a Pro user.\n\nYou can use the app in all its functionality.\nPlease contact us at xxx@xxx.com if you have any problem",
                      textAlign: TextAlign.center,
                      style: kSendButtonTextStyle,
                    )),
              ],
            ),
          )),
    );
  }
}