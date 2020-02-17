import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jasonw/models/MessageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

enum PlayerState { stopped, playing, paused }

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();

  void callChat() {
    print("call chat");
    createState().getAllChat();
  }
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _textFieldController = TextEditingController();
  List<MessageModel> _Messages = new List<MessageModel>();
  List<MessageModel> listm = new List<MessageModel>();
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;
  AudioPlayer audioPlayer;
  Duration duration;
  Duration position;
  String localFilePath;
  int last_position;
  Stream<int> stream;
  String baseUrl = "https://jasonwolverson.algorepublic.com";

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    initAudioPlayer();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessagejjj: $message");

        print("ob");
        Navigator.pushReplacementNamed(context, '/chatRoom');
        getAllChat();
        print("object");
        final notification = message['notification'];
        setState(() {
          print("title =$notification['title']  body = $notification['body']");
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];

        print("title =$notification['title']  body = $notification['body']");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    getAllChat();
  }

  @override
  void dispose() {
    print('dispose');
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.release();
    audioPlayer.stop();
    _isLoading = false;
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        audioPlayer.onDurationChanged.listen((Duration d) {
          print('Max duration: $d');
          setState(() => duration = d);
        });
        audioPlayer.onAudioPositionChanged.listen((Duration p) =>
            {print('current position  $p'), setState(() => position = p)});
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        //stop();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play(int positi) async {
    print('play');

    if (isPlaying) {
      stop(positi);
      _Messages.elementAt(last_position).is_play = false;
//        setState(() {
//          playerState = PlayerState.playing;
//        });

    }
//    else {
    _Messages.elementAt(positi).is_play = true;
    await audioPlayer.play("$baseUrl${_Messages.elementAt(positi).is_audio}");
    last_position = positi;
    setState(() {
      playerState = PlayerState.playing;
    });

//    }
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop(int positi) async {
    _Messages.elementAt(positi).is_play = false;
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.setVolume(0);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

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
          'Chat',
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
        margin: EdgeInsets.only(bottom: 10),
        child: ListView.builder(
          itemCount: _Messages.length,
          controller: _scrollController,
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: _Messages.elementAt(position).is_send == '1'
                        ? true
                        : false,
                    child: Bubble(
                        margin: BubbleEdges.only(top: 10, left: 60),
                        alignment: Alignment.topRight,
                        nip: BubbleNip.rightTop,
                        color: Color.fromRGBO(225, 255, 199, 1.0),
                        child: Column(
                          children: <Widget>[
                            Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(_Messages.elementAt(position).body,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                    "${_Messages.elementAt(position).created_at}",
                                  style: TextStyle(fontSize: 10,color: Colors.blueGrey),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  Visibility(
                    visible: (_Messages.elementAt(position).body != "null"
                            ? true
                            : false) &&
                        (_Messages.elementAt(position).is_receive == "1"
                            ? true
                            : false),
                    child: Bubble(
                        margin: BubbleEdges.only(top: 10, right: 60),
                        alignment: Alignment.topLeft,
                        nip: BubbleNip.leftTop,
                        child: Column(
                          children: <Widget>[
                            Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(_Messages.elementAt(position).body,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                "${_Messages.elementAt(position).created_at}",
                                  style: TextStyle(fontSize: 10,color: Colors.blueGrey),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  Visibility(
                    visible: _Messages.elementAt(position).is_audio != "null"
                        ? true
                        : false,
                    child: Bubble(
                        margin: BubbleEdges.only(top: 10, right: 60),
                        alignment: Alignment.topLeft,
                        nip: BubbleNip.leftTop,
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: new IconButton(
                                    onPressed:
                                        _Messages.elementAt(position).is_play
                                            ? () => stop(position)
                                            : () => play(position),
                                    iconSize: 25.0,
                                    icon: _Messages.elementAt(position).is_play
                                        ? new Icon(Icons.pause)
                                        : new Icon(Icons.play_arrow),
                                    color: Colors.cyan),
                              ),
                            ),
                            Align(
//                              width: 100,
//                              color: Colors.blueGrey,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "${_Messages.elementAt(position).created_at}",
                                  style: TextStyle(fontSize: 10,color: Colors.blueGrey),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(2),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 70,
                  alignment: Alignment.center,
//                  color: hexToColor('#3A3171'),
                  child: TextField(
                    controller: _textFieldController,
                    textAlign: TextAlign.left,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                        ),
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Type your message...",
                        fillColor: Colors.white70),
                  )),
              IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                    semanticLabel: 'Send your message!',
                  ),
                  onPressed: () {
                    if (_textFieldController.text.toString().isNotEmpty) {
                      sendMsg(_textFieldController.text.toString());
                    } else {
                      showToast("Please enter something",
                          gravity: Toast.BOTTOM);
                    }

                    // showToast(_textFieldController.text.toString(),gravity: Toast.BOTTOM);
                  })
            ],
          ),
        ),
      ),
    );
  }

  sendMsg(String msg) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId');
    print("userId= $userId");
    final Map<String, dynamic> data = {
      'sender_id': userId.toString(),
      'is_send': "1",
      'is_receive': "0",
      'body': msg,
    };
    _textFieldController.text = "";
    var jsonResponse;
    http.Response response = await http.post(
      "http://68.183.187.228/api/imessage/create_message",
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      //   showToast(jsonResponse["message"], duration: 4, gravity: Toast.CENTER);
//      showToast("Your appointment has been submitted to Jason!",
//          gravity: Toast.BOTTOM);

      int id = jsonResponse["data"]['id'];
      String body = jsonResponse["data"]['body'].toString();
      String is_send = jsonResponse["data"]['is_send'].toString();
      String is_audio = jsonResponse["data"]['is_audio'].toString();
      String is_receive = jsonResponse["data"]['is_receive'].toString();
      int user_id = jsonResponse["data"]['user_id'];
      String createdAt=jsonResponse["data"]['created_at'].toString();
      int conversation_id = jsonResponse["data"]['conversation_id'];

      print(is_audio);

      MessageModel msg = new MessageModel(
        id: id,
        body: body,
        is_send: is_send,
        is_receive: is_receive,
        user_id: user_id,
        created_at: createdAt,
        conversation_id: conversation_id,
        is_play: false,
        is_audio: is_audio,
      );

      listm.add(msg);

      _Messages.clear();
      _Messages.addAll(listm.reversed);

      setState(() {
        _scrollController.animateTo(0.0,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
      });
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);
      showToast("Please try again", duration: 4, gravity: Toast.CENTER);
    }
  }

  Future<void> getAllChat() async {
    print("gettAll list");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int userId = sharedPreferences.getInt('userId');
    var jsonResponse;
    String Url =
        'http://68.183.187.228/api/imessage/message_listing?sender_id=$userId';

    http.Response response = await http.get(Url);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      listm.clear();
      _Messages.clear();
      List Messages = jsonResponse["data"] as List;
      for (int i = 0; i < Messages.length; i++) {
        int id = Messages[i]['id'];
        String body = Messages[i]['body'].toString();
        String is_send = Messages[i]['is_send'].toString();
        String is_audio = Messages[i]['audio'].toString();
        String createdAt=Messages[i]['created_at'].toString();
        String is_receive = Messages[i]['is_receive'].toString();
        int user_id = Messages[i]['user_id'];
        int conversation_id = Messages[i]['conversation_id'];

        MessageModel msg = new MessageModel(
          id: id,
          body: body,
          is_send: is_send,
          is_receive: is_receive,
          user_id: user_id,
          conversation_id: conversation_id,
          is_play: false,
          created_at: createdAt,
          is_audio: is_audio,
        );


        listm.add(msg);
      }

      print(listm.length);

//
//      if (!mounted) return;
      setState(() {
        _Messages.addAll(listm.reversed);
        _isLoading = false;
//        _scrollController.animateTo(0.0,
//            curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
      });
    } else {
      jsonResponse = json.decode(response.body);
      var success = jsonResponse["success"];
      print(jsonResponse);
      print(success);
      print(response.body);

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
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
