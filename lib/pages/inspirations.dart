import 'package:custom_chewie/custom_chewie.dart';
import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import 'comment_page.dart';

class Inspirations extends StatefulWidget {
  final MainModel model;

  Inspirations(this.model);

  @override
  _InspirationsState createState() => _InspirationsState();
}

class _InspirationsState extends State<Inspirations> {
//  final String urlToStreamVideo = 'http://213.226.254.135:91/mjpg/video.mjpg';

  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model.fetchInspirations();
//    widget.model.fetchInspirationComments();
    setState(() {
      _controller = new VideoPlayerController.network(
        '',
      );
      //Your state change code goes here
    });
    if (!mounted) return;
  }

  Widget _ShowUserInfo() {
//    print('${model.user.email}');
    if (widget.model.user == null) {
      return Text('test@gmail.com');
    } else {
      return Text('${widget.model.user.email}');
    }
  }

  Widget _buildInspirationList() {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.allInspiratios.length == 0) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: model.allInspiratios.length,
            itemBuilder: (BuildContext ctxt, int Index) {
              if (model.allInspiratios[Index].file_content_type ==
                      'image/jpeg' ||
                  model.allInspiratios[Index].file_content_type ==
                      'image/png') {
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color.fromARGB(255, 255, 255, 255),
//                  shape: Bo
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                  elevation: 5,
                  child: Container(
//                  height: 60,
//                padding: EdgeInsets.only(bottom: 10.0),
//                  width: 260,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                model.allInspiratios[Index].title.toUpperCase(),
                                style: TextStyle(
                                    color: hexToColor('#3A3171'),
                                    fontSize: 15.0,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
//
                        ),
                        Container(
                            child: Image.network('http://68.183.187.228/' +
                                model.allInspiratios[Index].file)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PopupMenuButton(itemBuilder: (context) {
                              var list = List<PopupMenuEntry<Object>>();
                              list.add(
                                PopupMenuItem(
                                  child: Text("Like"),
                                  value: 'Like',
                                ),
                              );

                              list.add(
                                PopupMenuItem(
                                  child: Text("Dislike"),
                                  value: 'Dislike',
                                ),
                              );

                              //                              list.add(
                              //                                PopupMenuDivider(
                              //                                  height: 10,
                              //                                ),
                              //                              );

                              return list;
                            }, onSelected: (value) {
                              print("value:$value");

                              //                              _submitForm(
                              //                                  model.updateUserTasks,
                              //                                  model.selectUserTask,
                              //                                  model.selectedTaskIndex,
                              //                              );
                              model.selectInspiration(
                                  model.allInspiratios[Index].inspirationID);
                              model.selectedInspirationsIndex;
                              model.updateInspiration(value);
                              model.fetchInspirations();
                            }),

                            IconButton(
                              icon: Icon(model.allInspiratios[Index].isliked
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {
//                                model.selectProduct(model.allProducts[productIndex].id);
//                                model.toggleProductFavoriteStatus();
                              },
                            ),

                            Text('Likes ${model.allInspiratios[Index].likes}'),

//                            IconButton(
//
//                                icon: Icon(Icons.thumb_up),
//                                onPressed: (){
//                                  model.selectInspiration(model.allInspiratios[Index].inspirationID);
//                                  model.selectedInspirationsIndex;
//                                  model.updateInspiration();
//                                  model.fetchInspirations();
//                                }
//                            ),
//                            Text('${model.allInspiratios[Index].likes}'),
//                            IconButton(icon: Icon(Icons.thumb_down),
//                                onPressed: (){
//                                  model.selectInspiration(model.allInspiratios[Index].inspirationID);
//                                  model.selectedInspirationsIndex;
//                                  model.unlikeInspiration();
//                                }
//                            ),
//                            Text('${model.allInspiratios[Index].likes}'),
                            FlatButton(
                              color: hexToColor('#ffffff'),
//                              child: Text('Add Comment' , style:TextStyle(color: hexToColor('#ffffff')),),
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(Icons.comment),
                                  Text("Comments")
                                ],
                              ),

                              onPressed: () {
                                model.selectInspiration(
                                    model.allInspiratios[Index].inspirationID);
//                                model.fetchInspirationComments();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                          model.allInspiratios[Index], model)),
                                );
                              },
                            ),

//                            _buildSelectButton(context, Index, model),
                          ],
//
                        ),
                      ],
                    ),
                  ),
                );
              } else if (model.allInspiratios[Index].file_content_type ==
                  'video/mp4') {
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color.fromARGB(255, 255, 255, 255),
//                  shape: Bo
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  margin: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
                  elevation: 5,
                  child: Container(
//                  height: 60,
//                padding: EdgeInsets.only(bottom: 10.0),
//                  width: 260,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                model.allInspiratios[Index].title.toUpperCase(),
                                style: TextStyle(
                                    color: hexToColor('#3A3171'),
                                    fontSize: 15.0,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
//
                        ),

//                        Container(
//                            child: File.network('http://68.183.187.228/'+ model.allInspiratios[Index].file)
//                        )

                        new Chewie(
                          _controller = new VideoPlayerController.network(
                              'https://jasonwolverson.algorepublic.com/' +
                                  model.allInspiratios[Index].file),
                          aspectRatio: 3 / 2,
                          autoInitialize: true,
                          autoPlay: false,
                          looping: false,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PopupMenuButton(itemBuilder: (context) {
                              var list = List<PopupMenuEntry<Object>>();
                              list.add(
                                PopupMenuItem(
                                  child: Text("Like"),
                                  value: 'Like',
                                ),
                              );

                              list.add(
                                PopupMenuItem(
                                  child: Text("Dislike"),
                                  value: 'Dislike',
                                ),
                              );

                              //                              list.add(
                              //                                PopupMenuDivider(
                              //                                  height: 10,
                              //                                ),
                              //                              );

                              return list;
                            }, onSelected: (value) {
                              print("value:$value");

                              //                              _submitForm(
                              //                                  model.updateUserTasks,
                              //                                  model.selectUserTask,
                              //                                  model.selectedTaskIndex,
                              //                              );
                              model.fetchInspirations();
                              model.selectInspiration(
                                  model.allInspiratios[Index].inspirationID);
                              model.selectedInspirationsIndex;
                              model.updateInspiration(value);
                            }),
                            Text('Likes ${model.allInspiratios[Index].likes}'),

//                            IconButton(
//
//                                icon: Icon(Icons.thumb_up),
//                                onPressed: (){
//                                  model.selectInspiration(model.allInspiratios[Index].inspirationID);
//                                  model.selectedInspirationsIndex;
//                                  model.updateInspiration();
//                                  model.fetchInspirations();
//                                }
//                            ),
//                            Text('${model.allInspiratios[Index].likes}'),
//                            IconButton(icon: Icon(Icons.thumb_down),
//                                onPressed: (){
//                                  model.selectInspiration(model.allInspiratios[Index].inspirationID);
//                                  model.selectedInspirationsIndex;
//                                  model.unlikeInspiration();
//                                }
//                            ),
//                            Text('${model.allInspiratios[Index].likes}'),
                            FlatButton(
                              color: hexToColor('#ffffff'),
//                              child: Text('Add Comment' , style:TextStyle(color: hexToColor('#ffffff')),),
                              child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(Icons.comment),
                                  Text("Comments")
                                ],
                              ),

                              onPressed: () {
                                model.selectInspiration(
                                    model.allInspiratios[Index].inspirationID);
//                                model.fetchInspirationComments();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage(
                                          model.allInspiratios[Index], model)),
                                );
                              },
                            ),

//                            _buildSelectButton(context, Index, model),
                          ],
//
                        ),
//                        Row(
//                          children: <Widget>[
//                            Padding(
//                                padding: EdgeInsets.all(10.0),
//                                child: IconButton(icon: Icon(Icons.thumb_up),
//                                    onPressed: (){
////                                    model.selectDailyPlan('${model.alluserTasks[Index].id}');
////                                    model.updateUserTasks();
////                                    print();
//
//
//                                    }
//                                )
//                            ),
//                          ],
////
//                        ),
                      ],
                    ),
                  ),
                );
              }
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: hexToColor("#ffffff"),
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: new Text(
          'INSPIRATIONS',
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
            icon: Icon(Icons.home),
              // icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              })
        ],
      ),
      //drawer: CustomSideDraw(),
      body: new Stack(
//        shrinkWrap: true,

        children: <Widget>[
          new Container(
//                      height:120.0,
            margin: EdgeInsets.only(top: 10.0),
//                      padding: EdgeInsets.all(20),
            child: _buildInspirationList(),
          ),

//            new Container(
////                        width: 50,
////                        height: 40,
////                      opacity:0.0,
//                decoration: new BoxDecoration(color: hexToColor("#3A3171") ,
////                        image: DecorationImage(
////                          image: ExactAssetImage('images/dots.png'),
////                          fit: BoxFit.cover,
////                        ),
//                  border: Border(bottom: BorderSide(color: hexToColor('#3A3171') ,)),
//
//                ),
//                padding: EdgeInsets.fromLTRB(30,5,0,5),
//                margin: EdgeInsets.only(top: 20.0),
//                child:Row(
//                  children: <Widget>[
//                    Expanded(
//                        child: Container(
//                          color: hexToColor('#3A3171'),
////                              textColor: Colors.white,
////                              elevation: 0.0,
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(child:  new Text('20-August-2019' , style: TextStyle(color: Colors.white, fontSize:12.0,fontFamily: 'opensans'),)),
//                              Spacer(),
//                              Expanded(child: new Icon(Icons.calendar_today, color: Colors.white, size:14.0 ),)
//                            ],
//                          ),
//                        )),
//
//                  ],
//                )
//
//            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: hexToColor('#3A3171'),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/task_list');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 15, 15, 15),
                  child: Text(
                    'DAILY PLAN',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/journal');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'JOURNAL',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/reflect');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'REFLECT',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/inpirations');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'INSPIRATION',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/news');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'HAPPENING',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/chat');
//                    print('chat press');
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'CHAT',
                    style: TextStyle(
                        color: hexToColor('#BCB2C6'),
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/seeMe');
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'SEE ME',
                      style: TextStyle(
                          color: hexToColor('#BCB2C6'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  )),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/about');
                },
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                          color: hexToColor('#ffffff'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/reflect_admin');
                },
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Manage Reflect',
                      style: TextStyle(
                          color: hexToColor('#BCB2C6'),
                          fontFamily: 'opensans',
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
