import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class MonthlyPaymentPage extends StatefulWidget {
  @override
  _MonthlyPaymentPageState createState() => _MonthlyPaymentPageState();
}

class _MonthlyPaymentPageState extends State<MonthlyPaymentPage> {
  final MainModel _model = MainModel();
  @override
  Widget build(BuildContext context) {
    return  ScopedModel<MainModel>(
        model: _model,
        child: Scaffold(
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
                child: Center(
                  child: Text(
                    "SUBSCRIPTION",
                    style: TextStyle(
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        color: Color(0Xff594072),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                  Text(
                    "Monthly Subscription",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0Xff594072),),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Charged Monthly",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0Xff594072),),
                  ),
                ],),
                  Column(crossAxisAlignment:CrossAxisAlignment.end,children: [
                    Row(children: [
                    Container(child: Row(children: [Padding(padding: EdgeInsets.only(top: 5),child: Text("ZAR",style: TextStyle(fontSize: 24,color: Color(0XFF594072),),)),
                      Text("199",style: TextStyle(fontSize: 30,color: Color(0XFF594072),),),
                        Padding(padding: EdgeInsets.only(bottom: 15),child: Text(".99",style: TextStyle(color: Color(0XFF594072)),))
                    ],),)
                  ],),
                    Align(alignment:Alignment.centerRight,child: Text("/month",style: TextStyle(color: Color(0XFF594072)),))
                  ],)
                ],)
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20,top: 10),
                child: Align(alignment:Alignment.centerRight,child: Container(width:130,height: 1, color: Color(0XFF594072),),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
                child: RaisedButton(color: Color(0XFF594072),
                  child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16),),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => PaymentPage()),
                    // );
                    // _calendarController.setSelectedDay(DateTime(2019, 7, 10), runCallback: true);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
