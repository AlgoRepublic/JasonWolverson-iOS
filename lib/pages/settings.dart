import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

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

  Future<bool> _onCancelSubscription(MainModel model) {
    return showDialog(
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
                    setState(() {
                      _isLoading = true;
                    });
                    var results = await model.cancelSubscription();
                    print("in settings page");
                    print(results);
                    setState(() {
                      _isLoading = false;
                    });
                    if (results['success']) {
                      if (results['data']['status'] == 'success') {
//                        Navigator.of(context).pop(true);
////                        model.logout();
//                        Navigator.of(context).pushNamedAndRemoveUntil(
//                            '/dashboard', (Route<dynamic> route) => false);
                        model.logout();
                        Navigator.of(context).pop(true);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/Auth', (Route<dynamic> route) => false);
                      } else
                        _showDialogue();
                    } else
                      _showDialogue();
                  },
                );
              }),
            ],
          );
        });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Card(
              elevation: 1,
              child: ScopedModelDescendant(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return Column(
                  children: [
                    GestureDetector(
                      child: ListTile(
                        leading: Image.asset(
                          'images/close.png',
                          width: 25,
                          height: 25,
                          color: Color(0XFF3A3171),
                        ),
                        title: Text("Cancel Subscription"),
                      ),
                      onTap: () {
                        _onCancelSubscription(model);
                      },
                    ),
                    GestureDetector(
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
                    )
                  ],
                );
              }),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
