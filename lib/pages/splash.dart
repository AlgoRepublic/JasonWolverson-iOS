import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, _navigationPage);
  }



  final MainModel model = MainModel();

  @override
  void initState() {
    super.initState();
    model.autoAuthenticate();
    startTime();
  }
  Widget _navigationPage() {
    print('hi');

//    Navigator.of(context).pushReplacementNamed('/Auth');
//    return  ScopedModelDescendant(
//      builder: (BuildContext context, Widget child , MainModel model){
//        print('hi');
        if (model.user == null) {

          Navigator.of(context).pushReplacementNamed('/Auth');
        } else {
          print('ye hai ');
          print(model.user.email);
          Navigator.of(context).pushReplacementNamed('/Dashboard');
        }
//
//      },
//    );


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/Splash.png'),
              fit: BoxFit.cover,

          )
        ),
      ),
    );
  }
}


//class Splash extends StatefulWidget {
//  @override
//  _SplashState createState() => _SplashState();
//}
//
//class _SplashState extends State<Splash> {
////  @override
//  void iniState(){
//    super.initState();
//    Future.delayed(Duration(seconds: 3),
//        (){
//          Navigator.push(context, MaterialPageRoute(builder: (context) => new Login(),
//          ),);
//        }
//    );
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: FlutterLogo(
//          size: 400,
//        ),
//      ),
//    );
//  }
//}
