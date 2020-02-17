import 'package:flutter/material.dart';

class CardHolder extends StatefulWidget {
  @override
  _CardHolderState createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  var Category_list = [
    {
      "name": "DAILY PLAN",
      "picture": "images/daily-plan.png",
      'url': '/task_list',
    },
    {
      "name": "JOURNAL",
      "picture": "images/journal.png",
      'url': '/journal',
    },
    {
      "name": "REFLECT",
      "picture": "images/reflect.png",
      'url': '/reflect',
    },
    {
      "name": "INSPIRATION",
      "picture": "images/inspiration.png",
      'url': '/inpirations',
    },
    {
      "name": "HAPPENING",
      "picture": "images/happening.png",
      'url': '/news',
    },
    {
      "name": "ABOUT US",
      "picture": "images/about-us.png",
      'url': '/about',
    },
    {
      "name": "CHAT",
      "picture": "images/chat.png",
      'url': '/chatRoom',
    },
    {
      "name": "SEE ME",
      "picture": "images/see-me.png",
      'url': '/seeMe',
    },
    {
      "name": "HEAL",
      "picture": "images/heal.png",
      'url': '/heal',
    },
    {
      "name": "PRODUCT",
      "picture": "images/product_icon.png",
      'url': '/products',
    }
  ];

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return GridView.builder(
        itemCount: Category_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_cat(
            cat_name: Category_list[index]['name'],
            cat_picture: Category_list[index]['picture'],
            cat_url: Category_list[index]['url'],
          );
        });
  }
}

class Single_cat extends StatelessWidget {
  final String cat_name;
  final String cat_picture;
  final String cat_url;

  Single_cat({this.cat_name, this.cat_picture, this.cat_url});

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Material(
          child: InkWell(
            onTap: () {
//
//
//                print('i');
              if (Navigator.pushReplacementNamed(context, cat_url) == 'chat') {
                print('this is chat tab ');
              }
              Navigator.pushReplacementNamed(context, cat_url);
            },
            child: Card(
              elevation: 0.4,
              child: new Container(
//                  padding: new EdgeInsets.fromLTRB(22.0,20.0,20.0,10.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new IconButton(
                        icon: new Image.asset(
                      cat_picture,
                      width: 50,
                      height: 50,
                          color: hexToColor('#3A3171'),
                    )),
                    Padding(padding: new EdgeInsets.all(3.0)),
                    new Text(
                      cat_name,
                      style: TextStyle(
                          color: hexToColor('#3A3171'),
                          fontSize: 14.0,
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
//                    child: Image.network(
//                      cat_picture, width: 30.0,
//
//                    ),
              ),
            ),
          ),
        ),
      ),
//      ),
    );
  }
}
