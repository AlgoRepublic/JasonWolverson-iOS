import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

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
      body: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Card(
          elevation: 1,
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  'images/close.png',
                  width: 25,
                  height: 25,
                  color: Color(0XFF3A3171),
                ),
                title: Text("Cancel Subscription"),
              ),
              ScopedModelDescendant(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return GestureDetector(
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
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
