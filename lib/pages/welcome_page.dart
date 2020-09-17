import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jasonw/pages/paymentPage.dart';
import 'package:jasonw/pages/payment_page.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final MainModel _model = MainModel();
  String text =
      'Jason Wolverson started doing readings at a young age and has evolved his offering into that of a mindful business mentor, often in daily contact with key industry leaders and members of government based in Europe, the America’s, Africa and India.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        children: <Widget>[
          new Container(
            color: Colors.white,
            //              height: 250,
            child: new GridTile(
              child: new Container(
                //                  color: Colors.black,

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
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
            child: RaisedButton(color: Color(0XFF594072),
              child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MonthlyPaymentPage()),
                );
                // _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
              },
            ),
          ),
        ],
      ),
    );
  }
}
