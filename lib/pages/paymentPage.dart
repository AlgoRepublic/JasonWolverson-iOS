import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'news.dart';

class PaymentPage extends StatefulWidget {
  final url;
  final eventId;
  final productId;

  const PaymentPage({Key key, this.url, this.eventId, this.productId})
      : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = false;

  final _key = UniqueKey();
  num _stackToView = 1;
  bool firstTime = true;
  String currentUrl;

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    currentUrl = widget.url;
    print("url=$currentUrl");
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: currentUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    currentUrl = url;
                    if (url ==
                        "https://jasonwolverson.algorepublic.com/success") {
                      if (widget.eventId != null) {
                        setState(() {
                          isLoading = true;
                          //_stackToView = 0;
                        });
                        goingToEvent();
                      } else if (widget.productId != null) {
                        setState(() {
                          isLoading = true;
                          //_stackToView = 0;
                        });
                        buyProduct();
                      }
                    }
                    else if(url=="https://jasonwolverson.algorepublic.com/cancel"){
                      showToast("Please try again",gravity: Toast.BOTTOM,duration: 4);
                      Navigator.pop(context);
                    }

                    setState(() {
                      //isLoading = true;
                      _stackToView = 0;
                    });
                  },
                  onPageStarted: (String url) {
                    print('Page Start loading: $url');
                    currentUrl = url;
                    if (firstTime == false) {
                      setState(() {
                        _stackToView = 1;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          if (currentUrl != widget.url)
            Positioned(
              width: 40.0,
              height: 40.0,
              bottom: 25.0,
              left: 10.0,
              child: NavigationControls(_controller.future),
            ),
          if (_stackToView == 1)
            Container(
              color: Color(0xFF0E3311).withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    hexToColor('#3C8484'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  goingToEvent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print("event");
    Map data = {
      'event_id': widget.eventId,
      'status': "1",
    };
    var jsonResponse;
    http.Response response =
        await http.post("http://68.183.187.228/api/user_event_status",
            headers: {
              'Auth-Token': token,
            },
            body: data);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
//      sharedPreferences.setString(
//          "eventId", jsonResponse["result"]["event_id"].toString());
      showToast("Thank you for booking Event",
          duration: 4, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      setState(() {
        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast(jsonResponse["message"], duration: 8, gravity: Toast.BOTTOM);
    }
  }

  buyProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print("product ${widget.productId}  $token");
    Map data = {'product_id': widget.productId.toString()};
    var jsonResponse;
    http.Response response =
        await http.post("http://68.183.187.228/api/order_product",
            headers: {
              'Auth-Token': token,
            },
            body: data);

    print(response);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
//      sharedPreferences.setString(
//          "eventId", jsonResponse["result"]["event_id"].toString());
      showToast(" Thank you for visiting us and making your purchase!",
          duration: 4, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      setState(() {
        isLoading = false;
      });
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast(jsonResponse["message"], duration: 8, gravity: Toast.BOTTOM);
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

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return FloatingActionButton(
          onPressed: !webViewReady
              ? null
              : () => navigate(context, controller, goBack: true),
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.black,
          //   label: Text(""),
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Sem histórico anterior")),
      );
    }
  }
}
