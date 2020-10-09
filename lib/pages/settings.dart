import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jasonw/Helper/generic_widget.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/purchaser_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../scoped_models/main.dart';
import 'InAppPurchases/components.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<bool> _onBackPressed(Function logout) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Log out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  logout();
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Auth', (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        });
  }

  _showDialogue() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'An Error Occurred',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('Internet Problem or some internal server error'),
          );
        });
  }

  void loadingAction(MainModel model)async{
    print("ppppppppppp");
    setState(() {
      _isLoading = true;
    });
    try {
//      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
//      print('restore completed');
//      print(restoredInfo.toString());
//                      print(restoredInfo.entitlements.all['monthly_subscribed_users'].isActive);
      try {
        PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
        // ... check restored purchaserInfo to see if entitlement is now active
        print("checkrestoredinformation");
        print(restoredInfo);
      } on PlatformException catch (e) {
        // Error restoring purchases
      }
      Purchases.addPurchaserInfoUpdateListener((purchaserInfo) => {
        // handle any changes to purchaserInfo
        print(purchaserInfo)
      });

      appData.isPro = false;
      setState(() {
        _isLoading = false;
      });

      print('is user pro? ${appData.isPro}');

      if (!appData.isPro) {
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
                  'Your purchase has been restored!',
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
                Navigator.pushReplacementNamed(context, '/welcomePage');
              },
              width: 127,
              color: kColorAccent,
              height: 52,
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          style: kWelcomeAlertStyle,
          image: Image.asset(
            "images/inspiration.png",
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
                Navigator.of(context, rootNavigator: true).pop();
              },
              width: 127,
              color: kColorAccent,
              height: 52,
            ),
          ],
        ).show();
      }
    } on PlatformException catch (e) {
      print('----xx-----');
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }
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

  Future<bool> _onCancelSubscription(MainModel model,Function loadingAction) {
    return
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Cancel Subscription',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content:
            Text('Are you sure you want to cancel subscription?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return FlatButton(
                  child: Text('YES'),
                  onPressed: () async {
                    loadingAction(model);
                    Navigator.of(context).pop(false);
                  },
                );
              }),
            ],
          );
        });
  }
  Future<void> _launchUniversalLinkIos(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: Text("Settings"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, '/dashboard'), // POPPING globalContext
              ),
              backgroundColor: Color(0XFF3A3171),
              centerTitle: true,
              automaticallyImplyLeading: true,
              elevation: 0.0,
            ),
            body:Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Card(
                elevation: 1,
                child: ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return Center(
                    child: GestureDetector(
                      child: ListTile(
                        leading: Image.asset(
                          'images/logout.png',
                          width: 25,
                          height: 25,
                          color: Color(0XFF3A3171),
                        ),
                        title: Text("Log Out"),
                      ),
                      onTap: () {
                        _onBackPressed(model.logout);
                      },
                    ),
                  );
                }),
              ),
            ),),
        _isLoading
            ? GenericWidget(
          type: 1,
        )
            : Container(),
      ],
    );
  }
}
