import 'dart:convert';

//import 'package:braintree_payment/braintree_payment.dart';
import 'package:flutter/material.dart';
import 'package:jasonw/models/productsModel.dart';
import 'package:jasonw/pages/paymentPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController _textFieldController = TextEditingController();

  List<ProductModel> _productList = new List<ProductModel>();
  List<ProductModel> listm = new List<ProductModel>();

  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;
  String clientNonce =
      "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZG"
      "ZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0Z"
      "WRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkP"
      "TM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maW"
      "dVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFu"
      "dHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp"
      "7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiw"
      "iZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIs"
      "ImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21"
      "lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2"
      "V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5"
      "icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY"
      "3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlR"
      "W5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaW"
      "RnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUu"
      "Y29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM"
      "6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb2"
      "0iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpc"
      "m9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllb"
      "nQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZ"
      "GJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";

  payNow() async {
//    BraintreePayment braintreePayment = new BraintreePayment();
//    var data = await braintreePayment.showDropIn(
//        nonce: clientNonce,
//        inSandbox: true,
//        amount: "2.0",
//        enableGooglePay: true);
//    print("Response of the payment $data");
//    showThankYouDialog(context);
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getProducts();
    // print("comment count ${_Comment.length}");
    super.initState();
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _isLoading
        ? new Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'Products'.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(
              context, '/dashboard'), // POPPING globalContext
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: _productList.length,
          controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return InkWell(
              child: Container(
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      color: Colors.grey[200],
                      child: setImage(_productList.elementAt(position).image),
                    )),
                    Expanded(
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                                "${_productList.elementAt(position).name.toUpperCase()}         \ZAR ${_productList.elementAt(position).price}",
                                style: TextStyle(
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.bold)),
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          Container(
                            child: Text(
                                _productList.elementAt(position).description,
                                style: TextStyle(fontFamily: 'opensans')),
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              onTap: () {
                getPaymentUrl(position);
//                showAlertDialog(context, position);
              },
            );
          },
        ),
      ),
    );
  }

  Widget setImage(String path) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.center,
          image: new NetworkImage(
            "http://68.183.187.228$path",
          ),
        ),
      ),
    );
//      Container(
//        child: CachedNetworkImage(
//          imageUrl: "",
//          fit: BoxFit.contain,
//        )
//    );
  }

  showAlertDialog(BuildContext context, int position) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(_productList.elementAt(position).name.toUpperCase()),
      content: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(_productList.elementAt(position).description,
                  style: TextStyle(
                      fontFamily: 'opensans', color: Colors.blueGrey)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white70,
                    child:
                        Text("Cost:", style: TextStyle(fontFamily: 'opensans')),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text("\ZAR ${_productList.elementAt(position).price}",
                        style: TextStyle(fontFamily: 'opensans')),
                  ),
                ),
              ],
            ),
            Container()
          ],
        ),
      ),
      actions: [
//        FlatButton(
//          child: Text("CANCEL"),
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//        ),
        FlatButton(
          child: Text("Pay".toUpperCase()),
          onPressed: () {
            setState(() {
              getPaymentUrl(position);
            });

            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showThankYouDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Smash Life".toUpperCase()),
      content: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("Thank you for visiting us and making your purchase!",
                  style: TextStyle(fontFamily: 'opensans')),
            ),
          ],
        ),
      ),
      actions: [
//        FlatButton(
//          child: Text("CANCEL"),
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//        ),
        FlatButton(
          child: Text("OK".toUpperCase()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print(token);
    var jsonResponse;
    String Url = "http://68.183.187.228/api/product_listing";

    http.Response response = await http.get(Url, headers: {
      'Auth-Token': token,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      var success = jsonResponse["success"];
      print(success);

      List products = jsonResponse["data"] as List;

      for (int i = 0; i < products.length; i++) {
        int id = products[i]['id'];
        String name = products[i]['name'].toString();
        String description = products[i]['description'].toString();
        double price = products[i]['price'];
        String image = products[i]['image'].toString();

        print(name);
        ProductModel feed = new ProductModel(
            id: id,
            name: name,
            description: description,
            price: price,
            image: image);

        // print(feed.likes);
        _productList.add(feed);
        setState(() {});
      }
      print('test');
      print(_productList.length);
    } else if (response.statusCode == 401) {
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      setState(() {});
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }

  getPaymentUrl(int position) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    String email = sharedPreferences.getString("userEmail");
    String name = "farhat";
    print(token);
    var jsonResponse;
    String url =
        "http://68.183.187.228/api/payfast_url?user_name=$name&email=$email&price=${_productList.elementAt(position).price}&title=${_productList.elementAt(position).name}&product_id=${_productList.elementAt(position).id}";

    http.Response response = await http.get(url, headers: {
      'Auth-Token': token,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      //   var success = jsonResponse["success"];
      String url = jsonResponse["data"]["url"];
      sharedPreferences.setString("url", url);
      print(url);
      //   print(success);
      //   if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentPage(
                url: url, productId: _productList.elementAt(position).id)),
      );
      //   Navigator.pushReplacementNamed(context, '/paymentPage');
      //   }

      print('test');
    } else if (response.statusCode == 401) {
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      setState(() {});
      showToast(jsonResponse["message"], duration: 4, gravity: Toast.BOTTOM);
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
