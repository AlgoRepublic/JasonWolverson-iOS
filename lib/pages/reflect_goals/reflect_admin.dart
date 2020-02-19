import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import '../reflect_goals/reflect_list.dart';
import '../reflect_goals/reflect_edit.dart';
import 'package:scoped_model/scoped_model.dart';


class ReflectGoalsAdminPage extends StatelessWidget {

  final MainModel model;

  ReflectGoalsAdminPage(this.model);

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hexToColor("#3A3171"),
          centerTitle: true,
          elevation: 0.0,
          title: new Text(
            'Add Reflect',
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
                  Navigator.pushReplacementNamed(context, '/reflect_list');
                })
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Container(
              decoration: new BoxDecoration(
                color: hexToColor("#3A3171"),
                border: Border(
                    top: BorderSide(color: Colors.white24),
                    bottom: BorderSide(color: Colors.white24)),
              ),
              child: TabBar(
                labelColor: hexToColor('#ffffff'),
                indicatorColor: hexToColor('#ffffff'),
                unselectedLabelColor: hexToColor('#BCB2C6'),
                labelStyle: TextStyle(fontSize: 12.0, fontFamily: 'opensans'),
                tabs: <Widget>[
                  Tab(
                    text: 'Create Goals',
                  ),
                  Tab(
                    text: 'My Goals',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(

          children: <Widget>[ReflectGoalsEditPage(), ReflectGoalsListPage(model)],
        ),
      ),
    );
  }
}
