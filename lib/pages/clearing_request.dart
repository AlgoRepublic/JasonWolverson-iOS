import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ClearingRequestScreen extends StatefulWidget {
  @override
  _ClearingRequestScreenState createState() =>
      new _ClearingRequestScreenState();
}

class _ClearingRequestScreenState extends State<ClearingRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _symptonController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  bool selected_one = false;
  bool selected_two = false;
  File _image;

  @override
  void initState() {
    super.initState();
  }

  Future<void> submitData() async {
    if (!selected_one && !selected_two) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text("Alert"),
            ),
            content: Text("Please Select Type of Request"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);
    FormData formData = FormData.fromMap({
      "request_type": selected_one ? "personal" : "business",
      "reason": _reasonController.text,
      "details_of_property": _detailController.text,
      "symptoms": _symptonController.text,
      "address": _addressController.text,
      "image": _image != null
          ? await MultipartFile.fromFile(_image.path, filename: _image.path)
          : null,
    });
    showLoader();
    Response response;
    Dio dio = new Dio();
    response = await dio.post(
      "http://68.183.187.228/api/create_request",
      data: formData,
      options: new Options(
        headers: {"Auth-Token": token},
      ),
    );
    Navigator.of(context).pop();

    if (response.statusCode == 200 && response.data['success']) {
      Toast.show(response.data['message'].toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future getImage() async {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    var image = await ImagePicker.pickImage(
                      source: ImageSource.values[0],
                    );

                    setState(() {
                      _image = image;
                    });
                  }),
              new ListTile(
                leading: new Icon(Icons.photo_album),
                title: new Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  var image = await ImagePicker.pickImage(
                    source: ImageSource.values[1],
                  );

                  setState(() {
                    _image = image;
                  });
                },
              ),
              new ListTile(
                leading: new Icon(Icons.cancel),
                title: new Text('Cancel'),
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3A3171),
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          'Clearing Request'.toUpperCase(),
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
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 5.0,
                  ),
                  child: Text(
                    'SELECT TYPE',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected_one = true;
                            selected_two = false;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          margin: EdgeInsets.only(
                            right: 5.0,
                          ),
                          padding: EdgeInsets.all(
                            10.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selected_one ? Color(0xFF3A3171) : Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Color(0xFF3A3171),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'PERSONAL',
                              style: selected_one
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    )
                                  : TextStyle(
                                      color: Color(0xFF3A3171),
                                      fontSize: 14.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selected_one = false;
                            selected_two = true;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          margin: EdgeInsets.only(
                            left: 5.0,
                          ),
                          padding: EdgeInsets.all(
                            10.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                selected_two ? Color(0xFF3A3171) : Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Color(0xFF3A3171),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'BUSINESS',
                              style: selected_two
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    )
                                  : TextStyle(
                                      color: Color(0xFF3A3171),
                                      fontSize: 14.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    labelText: 'Address',
                    labelStyle: new TextStyle(
                        color: Color(0xFF3A3171), fontFamily: 'opensans'),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      borderSide:
                          new BorderSide(color: Colors.yellow, width: 0.0),
                    ),
                  ),
                  style: new TextStyle(
                      fontFamily: 'open sans',
                      color: Color(0xFF3A3171),
                      fontSize: 13.0,
                      height: 1.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                ),
                TextFormField(
                  controller: _reasonController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    labelText: 'Reasons',
                    labelStyle: new TextStyle(
                        color: Color(0xFF3A3171), fontFamily: 'opensans'),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      borderSide:
                          new BorderSide(color: Colors.yellow, width: 0.0),
                    ),
                  ),
                  style: new TextStyle(
                      fontFamily: 'open sans',
                      color: Color(0xFF3A3171),
                      fontSize: 13.0,
                      height: 1.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                ),
                TextFormField(
                  controller: _symptonController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    labelText: 'Symptons',
                    labelStyle: new TextStyle(
                        color: Color(0xFF3A3171), fontFamily: 'opensans'),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      borderSide:
                          new BorderSide(color: Colors.yellow, width: 0.0),
                    ),
                  ),
                  style: new TextStyle(
                      fontFamily: 'open sans',
                      color: Color(0xFF3A3171),
                      fontSize: 13.0,
                      height: 1.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                ),
                TextFormField(
                  controller: _detailController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3A3171), width: 1.0),
                    ),
                    labelText: 'Details',
                    labelStyle: new TextStyle(
                        color: Color(0xFF3A3171), fontFamily: 'opensans'),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                      borderSide:
                          new BorderSide(color: Colors.yellow, width: 0.0),
                    ),
                  ),
                  style: new TextStyle(
                      fontFamily: 'open sans',
                      color: Color(0xFF3A3171),
                      fontSize: 13.0,
                      height: 1.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: FlatButton.icon(
                      color: Color(0xFF3A3171),
                      onPressed: getImage,
                      icon: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    color: Color(0xFF3A3171),
                    textColor: Colors.white,
                    elevation: 0.0,
                    height: 52,
                    onPressed: submitData,
                    child: new Text(
                      'Submit',
                      style: TextStyle(fontSize: 14.0, fontFamily: 'opensans'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
