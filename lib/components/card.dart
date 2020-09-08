import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
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
      'video': 'https://app.jasonwolverson.net/videos/Video/daily_journal.mp4'
    },
    {
      "name": "JOURNAL",
      "picture": "images/journal.png",
      'url': '/journal',
      'video': 'https://app.jasonwolverson.net/videos/Video/journal.mp4'
    },
    {
      "name": "REFLECT",
      "picture": "images/reflect.png",
      'url': '/reflect',
      'video': 'https://app.jasonwolverson.net/videos/Video/reflections.mp4'
    },
    {
      "name": "INSPIRATION",
      "picture": "images/inspiration.png",
      'url': '/inpirations',
      'video': 'https://app.jasonwolverson.net/videos/Video/inspirations.mp4'
    },
    {
      "name": "HAPPENING",
      "picture": "images/happening.png",
      'url': '/news',
      'video': "https://app.jasonwolverson.net/videos/Video/what_happening.mp4"
    },
    {
      "name": "ABOUT US",
      "picture": "images/about-us.png",
      'url': '/about',
      'video': 'https://app.jasonwolverson.net/videos/Video/about_us.mp4'
    },
    {
      "name": "CHAT",
      "picture": "images/chat.png",
      'url': '/chatRoom',
      'video': 'https://app.jasonwolverson.net/videos/Video/chat.mp4'
    },
    {
      "name": "SEE ME",
      "picture": "images/see-me.png",
      'url': '/seeMe',
      'video': 'https://app.jasonwolverson.net/videos/Video/see_me.mp4'
    },
    {
      "name": "HEAL",
      "picture": "images/heal.png",
      'url': '/heal',
      'video': 'https://app.jasonwolverson.net/videos/Video/heal.mp4'
    },
    {
      "name": "PRODUCT",
      "picture": "images/product_icon.png",
      'url': '/products',
      'video': 'https://app.jasonwolverson.net/videos/Video/products.mp4'
    },
    {
      "name": "Clearing \n Requests",
      "picture": "images/broom.png",
      'url': '/clearingrequest',
      'video': 'https://app.jasonwolverson.net/videos/Video/clearing.mp4'
    },
    {
      "name": "Settings",
      "picture": "images/settings.png",
      'url': '/settings',
      'video': 'https://app.jasonwolverson.net/videos/Video/clearing.mp4'
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
            video_url: Category_list[index]['video'],
          );
        });
  }
}

class Single_cat extends StatelessWidget {
  final String cat_name;
  final String cat_picture;
  final String cat_url;
  final String video_url;

  Single_cat({this.cat_name, this.cat_picture, this.cat_url, this.video_url});

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
              // ignore: unrelated_type_equality_checks
              if (Navigator.pushNamed(context, cat_url) == 'chat') {
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

                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerItem(video_url , cat_name)),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top:10,bottom: 0,left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.video_call, size: 20,color: hexToColor('#3A3171'),),
                            Container(
//                            alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(top:0,bottom: 0,left: 4),
                              child: new Text(
                                'Play Video',
                                style: TextStyle(
                                    color: hexToColor('#3A3171'),
                                    fontSize: 11.0,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
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

class VideoPlayerItem extends StatefulWidget {
  final cat_name;
  final video_url;
  VideoPlayerItem(this.video_url, this.cat_name);
  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {

  VideoPlayerController _controller;
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  bool isLoading = true;

  @override
  void initState() {
    print(widget.video_url);
    super.initState();

    _controller = VideoPlayerController.network(
        widget.video_url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          isLoading = false;
        });
      });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          backgroundColor: hexToColor("#3A3171"),
          centerTitle: true,
          elevation: 0.0,
          title: new Text(
            widget.cat_name,
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
                  Navigator.pushReplacementNamed(context, '/dashboard');
                })
          ],

        ),
        body:
        isLoading ?

        Container(
          height: MediaQuery.of(context).size.height ,
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(hexToColor('#3A3171')), ),
          ),
        )
            :
        Container(
          height: MediaQuery.of(context).size.height ,
          color: Colors.black,
          child: Center(
            child: _controller.value.initialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: hexToColor('#3A3171'),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}

