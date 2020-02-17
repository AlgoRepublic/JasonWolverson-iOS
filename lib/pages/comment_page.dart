import 'package:flutter/material.dart';
import 'package:jasonw/models/inspirations.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';


class CommentPage extends StatefulWidget {
  final Inspiration ins;
  final MainModel model;

  CommentPage(
      this.ins,
      this.model,
//  this.model
      );

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

//  final ScrollController _scrollController = ScrollController();

  final Map<String, dynamic> _formData = {
    'description': null,
//    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  ScrollController _scrollController = new ScrollController();
  TextEditingController _textFieldController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  _onClear() {
    setState(() {
      _textFieldController.text = "";
    });
  }

  @override

  void initState() {
    super.initState();
    widget.model.fetchInspirationComments();

  }


  Widget _CommentList() {

    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.allComments.length == 0) {
            return Container(
                child: Center(
                  child: CircularProgressIndicator(),
//              child: Text('No Daily Plans found'),
                ));
          }

          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              controller: _scrollController,
              itemCount: model.allComments.length,
              padding: const EdgeInsets.all(2.0),
              itemBuilder: (BuildContext context, int Index) {
                return Card(
                  color: Color.fromARGB(255, 255, 255, 255),
//                  shape: Bo
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: Container(
//                  height: 60,
//                  width: 260,
                    child: Column(
                      children: <Widget>[
//                      Text('hi'),
                        ListTile(
                          title: Text(
                            model.allComments[Index].description,
                            style: TextStyle(
                                fontFamily: 'opensans',
                                color: hexToColor('#3A3171')),
                          ),
//                          trailing: Text(
//                            model.alldailyPlans[Index].time,
//                            style: TextStyle(
//                                fontFamily: 'opensans',
//                                color: hexToColor('#3A3171')),
//                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: hexToColor("#3A3171"),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'COMMENTS',
          style: TextStyle(
              color: Colors.white, fontFamily: 'opensans', fontSize: 16.0),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              })
        ],
      ),


      body:ListView(
//        child: Column(\
        children: <Widget>[
          _CommentList(),
        ],

      ),
      bottomNavigationBar: Padding( padding: MediaQuery.of(context).viewInsets,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model){
              return Container(
                height: 50,
//              width: 200,
                padding: EdgeInsets.only(left:20.0),
                color: hexToColor('#eeeeee'),
                child: ListView(

//            scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    Form(
                      key: _formKey,
                      child: Stack(
                        children: <Widget>[

                          TextFormField(
                            controller: _textFieldController,
//                        controller: email,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelStyle: new TextStyle(color: hexToColor("#3A3171") , fontFamily: 'opensans'),
                              hintText: 'Add Comment',
                            ),

                            validator: (val){
                              if (val.length==0){
                                return null;
                              }else{
                                return null;
                              }

                            },
                            onSaved: (String value) {
                              _formData['description'] = value;
                            },
                          ),

                          Positioned(
                            top: 0,
                            bottom: -5,
                            right: 0,
                            child:  IconButton(
                              onPressed: () {

                                model.selectInspiration(widget.ins.inspirationID);
                                model.fetchInspirationComments();
                                model.selectedInspirationsIndex;
                                print('ok');
                                _submitForm(
                                  model.AddComment,
                                );

                                _onClear();
                                _scrollController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );

                              },
                              icon: Icon(Icons.send , color: hexToColor('#3A3171'),),
                              iconSize: 18.0,
                              color: hexToColor("#3A3171"),
                            ),

                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      ),

    );
  }

  bool _handleScrollPosition(ScrollNotification notification) {
    print(notification.metrics.pixels);
    return true;
  }

  void _submitForm(Function AddComment) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
//    if (selectedInspirationIndex == -1) {
    AddComment(
      _formData['description'],
    ).then((bool success) {
      if (success) {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('Show Snackbar'),
//          duration: Duration(seconds: 3),
//        ));
//        showDialog(
//            context: context,
//            builder: (BuildContext context) {
//              return AlertDialog(
//                title: Text('wwwwoooo'),
//                content: Text('Please try again!'),
//                actions: <Widget>[
//                  FlatButton(
//                    onPressed: () => Navigator.of(context).pop(),
//                    child: Text('Okay'),
//                  )
//                ],
//              );
//            });
//          Navigator
//              .pushReplacementNamed(context, '/reflect_admin')
//              .then((_) => setSelectedInspiration(null));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Something went wrong'),
                content: Text('Please try again!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Okay'),
                  )
                ],
              );
            });
      }
    });
//      return RefreshIndicator(onRefresh: model.fetchProducts, child: content,) ;
//      Navigator.pushReplacementNamed(context, '/dashboard');
//    }

  }


//
}

