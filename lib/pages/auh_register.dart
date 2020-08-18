
//import 'dart:convert';
//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'auth.dart';
import 'package:intl/intl.dart';

enum AuthMode { SignUp }

class AuthRegister extends StatefulWidget {
  @override
  //  _AuthState createState() => _AuthState();
  State<StatefulWidget> createState() {
    return _AuthRegisterState();
  }
}

class _AuthRegisterState extends State<AuthRegister> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  DateTime date2;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'date_of_birth': null,
    'gender': null,
    //    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //TextEditingController email = new TextEditingController();
  //TextEditingController password = new TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _dobTextCOntroller = TextEditingController();
  final TextEditingController _relogionController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  List<String> religion = [];
  List<String> profession = [];
  List<String> interest = [];
  AuthMode _authMode = AuthMode.SignUp;
  bool _validatepassword = false;
  bool _validaterepassword = false;
  Widget _buildDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text(
          "${country.isoCode}",
          style: TextStyle(color: hexToColor('#3A3171')),
        ),
      ],
    ),
  );

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      onChanged: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  //  Widget _buildPasswordConfirmTextField() {
  //    return TextFormField(
  //      decoration: InputDecoration(
  //          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
  //      obscureText: true,
  ////      validator: (String value) {
  ////        if (_passwordTextController.text != value) {
  ////          return 'Passwords do not match.';
  ////        }
  ////      },
  //    );
  //  }

  void _submitForm(Function login) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await login(_formData['email'], _formData['password'],
        _formData['date_of_birth'], _formData['gender']);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  //Future<List> _login() async {
  //
  //
  //  final response = await http.post('http://68.183.187.228/api/auth/login' , body:{
  //    'email':email.text,
  //    'password':password.text,
  //  });
  //
  //  print(response.body);
  //
  //}

  TapGestureRecognizer _recognizer1;
  @override
  void initState() {
    super.initState();
    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Auth()));
      };
  }

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    double c_width = MediaQuery.of(context).size.width * 0.95;

    //
    DropdownButtonFormField _showPopupMenu() => DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      items: [
        DropdownMenuItem<String>(
          value: "1",
          child: Text(
            "Male",
          ),
        ),
        DropdownMenuItem<String>(
          value: "2",
          child: Text(
            "Female",
          ),
        ),
        DropdownMenuItem<String>(
          value: "3",
          child: Text(
            "Other",
          ),
        ),
      ],
      onChanged: (value) {
        print("value:$value");
        //        print(_ShowUserInfo());

        setState(() {
          _formData['gender'] = value;
        });
      },
      value: _formData['gender'],
      isDense: true,
      elevation: 2,
      hint: Text(
        "Please select the Gender",
        style: TextStyle(
            color: hexToColor("#3A3171"),
            fontFamily: 'opensans',
            fontSize: 15.0),
      ),
    );

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
          new Row(
            children: <Widget>[
              new Container(
                color: Colors.white,
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(35.0, 15.0, 15.0, 15.0),
                  padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0, 2),
                  decoration: new BoxDecoration(
                    border: new Border(
                      bottom: new BorderSide(
                        color: hexToColor("#3A3171"),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    //                border: new Border.all(color: Colors.blueAccent ,)
                  ),
                  child: new Text(
                    'REGISTER',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: hexToColor("#3A3171"),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                        fontFamily: 'opensans'),
                  ),
                ),
              )
            ],
          ),
          new Form(
            key: _formKey,
            child: new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
              child: new Container(
                child: new Center(
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 5.0)),
                      new TextFormField(
                        //                        controller: email,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Email',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            suffixIcon: Icon(
                              Icons.email,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide: new BorderSide(
                                    color: Colors.yellow, width: 0.0))),

                        validator: (val) {
                          if (val.length == 0) {
                            return "Email Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _formData['email'] = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'open sans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0,
                            height: 1.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        controller: _passwordTextController,
                        obscureText: true,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Password',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            errorText:
                            _validatepassword ? 'Password Invalid ' : null,
                            //                            hintText: 'Password',
                            //                            hintStyle: new st,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide:
                                new BorderSide(color: Colors.blue[700]))),
                        onChanged: (value) {
                          if (value.isEmpty || value.length < 6) {
                            setState(() {
                              _validatepassword = true;
                            });
                          } else {
                            setState(() {
                              _validatepassword = false;
                            });
                          }
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return "Password Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _formData['password'] = value;
                        },
                        //                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        obscureText: true,
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            errorText: _validaterepassword
                                ? 'Passwords do not match'
                                : null,
                            //                            hintText: 'Password',
                            //                            hintStyle: new st,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide:
                                new BorderSide(color: Colors.blue[700]))),
                        onChanged: (value) {
                          if (_passwordTextController.text != value) {
                            setState(() {
                              _validaterepassword = true;
                            });
                          } else {
                            setState(() {
                              _validaterepassword = false;
                            });
                          }
                        },
                        validator: (String value) {
                          if (_passwordTextController.text != value) {
                            return 'Passwords do not match.';
                          }
                        },
                        onSaved: (String value) {
                          _formData['password'] = value;
                        },
                        style: new TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      new TextFormField(
                        decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: hexToColor("#3A3171"), width: 1.0),
                            ),
                            labelText: 'Cellphone number',
                            labelStyle: new TextStyle(
                                color: hexToColor("#3A3171"),
                                fontFamily: 'opensans'),
                            //                            hintText: 'Password',
                            //                            hintStyle: new st,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            suffixIcon: Icon(
                              Icons.record_voice_over,
                              size: 18.0,
                              color: hexToColor("#3A3171"),
                            ),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                                borderSide:
                                new BorderSide(color: Colors.blue[700]))),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Cellphone Field Cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _formData['contact_number'] = value;
                        },
                        style: new TextStyle(
                            fontFamily: 'opensans',
                            color: hexToColor("#3A3171"),
                            fontSize: 13.0),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1935, 1, 1),
                              maxTime: DateTime.now(),
                              theme: DatePickerTheme(
                                headerColor: hexToColor("#3A3171"),
                                backgroundColor: Colors.white,
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                cancelStyle: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ), onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              }, onConfirm: (date) {
                                print('confirm $date');
                                _formData['date_of_birth'] = date.toString();
                                date2 = date;
                                print(DateFormat('yyyy-MM-dd').format(date2));
                                _dobTextCOntroller.text =
                                    DateFormat('yyyy-MM-dd').format(date2);
                                setState(() {});
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: IgnorePointer(
                          child: new TextFormField(
                            controller: _dobTextCOntroller,
                            onTap: () {},
                            decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: hexToColor("#3A3171"), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: hexToColor("#3A3171"), width: 1.0),
                                ),
                                labelText: 'Date of Birth',
                                labelStyle: new TextStyle(
                                    color: hexToColor("#3A3171"),
                                    fontFamily: 'opensans'),
                                hasFloatingPlaceholder: true,
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                    borderRadius:
                                    new BorderRadius.circular(4.0),
                                    borderSide: new BorderSide(
                                        color: Colors.blue[700]))),
                            style: new TextStyle(
                                fontFamily: 'opensans',
                                color: hexToColor("#3A3171"),
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      GestureDetector(
                        // When the child is tapped, show a snackbar.
                          onTap: () {
                            print("tapped");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(5.0),
                                  ),
                                ),
                                elevation: 0.0,
                                backgroundColor: Colors.white,
                                child: Container(
                                    height: 150.0,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: _relogionController,
                                          decoration: new InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: hexToColor("#3A3171"),
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: hexToColor("#3A3171"),
                                                  width: 1.0),
                                            ),
                                            labelText: 'Religion',
                                            labelStyle: new TextStyle(
                                                color: hexToColor("#3A3171"),
                                                fontFamily: 'opensans'),
                                            hasFloatingPlaceholder: true,
                                            alignLabelWithHint: true,
                                            suffixIcon: Icon(
                                              Icons.record_voice_over,
                                              size: 18.0,
                                              color: hexToColor("#3A3171"),
                                            ),
                                            fillColor: Colors.white,
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  4.0),
                                              borderSide: new BorderSide(
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 1.0),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                    const Radius.circular(
                                                      5.0,
                                                    ),
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(
                                                    top: 15.0,
                                                    left: 10.0,
                                                    right: 10.0),
                                                height: 40.0,
                                                width: 80.0,
                                                child: InkWell(
                                                  child: Center(
                                                    child: Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    print("cancel");
                                                    Navigator.of(context,
                                                        rootNavigator: true)
                                                        .pop('dialog');
                                                  },
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF3A3171),
                                                    border: Border.all(
                                                        color:
                                                        Color(0xFF3A3171),
                                                        width: 1.0),
                                                    borderRadius: BorderRadius
                                                        .all(const Radius
                                                        .circular(5.0))),
                                                margin: EdgeInsets.only(
                                                    top: 15.0,
                                                    left: 10.0,
                                                    right: 10.0),
                                                height: 40.0,
                                                width: 80.0,
                                                child: InkWell(
                                                  child: Center(
                                                    child: Text(
                                                      'ADD',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    var tempText =
                                                        _relogionController
                                                            .text;
                                                    _relogionController.text =
                                                    '';
                                                    religion.add(tempText);
                                                    print(religion.length);
                                                    print("add");
                                                    Navigator.of(context,
                                                        rootNavigator: true)
                                                        .pop('dialog');
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                          child: Container(
                            height: religion.isEmpty ? 60.0 : null,
                            padding: EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: hexToColor("#3A3171"), width: 1.0),
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(5.0))),
                            child: Wrap(
                              children: <Widget>[
                                if (religion.isEmpty)
                                  Container(
                                      padding:
                                      EdgeInsets.only(top: 15.0, left: 5.0),
                                      child: Text(
                                        "Religion",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: hexToColor("#3A3171"),
                                            fontFamily: 'opensans'),
                                      ))
                                else
                                  for (int i = 0; i < religion.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: InputChip(
                                        label: Text(religion[i]),
                                        onDeleted: () {
                                          religion.removeAt(i);
                                          setState(() {});
                                        },
                                        materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    )
                              ],
                            ),
                          )),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: new BoxDecoration(
                                    color: hexToColor("#ffffff"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: new Border.all(
                                      width: 1.0,
                                      color: hexToColor("#3A3171"),
                                    ),
                                  ),
                                  height: 55,
                                  width: c_width,
                                  child: CountryPickerDropdown(
                                    initialValue: 'ZA',
                                    itemBuilder: _buildDropdownItem,
                                    onValuePicked: (Country country) {
                                      print("${country.name}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 55,
                                  width: c_width,
                                  padding:
                                  EdgeInsets.only(left: 10.0, right: 10.0),
                                  decoration: new BoxDecoration(
                                    color: hexToColor("#ffffff"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: new Border.all(
                                      width: 1.0,
                                      color: hexToColor("#3A3171"),
                                    ),
                                  ),
                                  child: _showPopupMenu(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      GestureDetector(
                        // When the child is tapped, show a snackbar.
                        onTap: () {
                          print("tapped");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  const Radius.circular(5.0),
                                ),
                              ),
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              child: Container(
                                  height: 150.0,
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: _professionController,
                                        decoration: new InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: hexToColor("#3A3171"),
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: hexToColor("#3A3171"),
                                                width: 1.0),
                                          ),
                                          labelText: 'Profession',
                                          labelStyle: new TextStyle(
                                              color: hexToColor("#3A3171"),
                                              fontFamily: 'opensans'),
                                          hasFloatingPlaceholder: true,
                                          alignLabelWithHint: true,
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(4.0),
                                            borderSide: new BorderSide(
                                              color: Colors.blue[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  const Radius.circular(
                                                    5.0,
                                                  ),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              height: 40.0,
                                              width: 80.0,
                                              child: InkWell(
                                                child: Center(
                                                  child: Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  print("cancel");
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                },
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF3A3171),
                                                  border: Border.all(
                                                      color: Color(0xFF3A3171),
                                                      width: 1.0),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      const Radius.circular(
                                                          5.0))),
                                              margin: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              height: 40.0,
                                              width: 80.0,
                                              child: InkWell(
                                                child: Center(
                                                  child: Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  var tempText =
                                                      _professionController
                                                          .text;
                                                  _professionController.text =
                                                  '';
                                                  profession.add(tempText);
                                                  print(profession.length);
                                                  print("add");
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          height: profession.isEmpty ? 60.0 : null,
                          padding: EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: hexToColor("#3A3171"), width: 1.0),
                              borderRadius:
                              BorderRadius.all(const Radius.circular(5.0))),
                          child: Wrap(
                            children: <Widget>[
                              if (profession.isEmpty)
                                Container(
                                    padding:
                                    EdgeInsets.only(top: 15.0, left: 5.0),
                                    child: Text(
                                      "Profession",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: hexToColor("#3A3171"),
                                          fontFamily: 'opensans'),
                                    ))
                              else
                                for (int i = 0; i < profession.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InputChip(
                                      label: Text(profession[i]),
                                      onDeleted: () {
                                        profession.removeAt(i);
                                        setState(() {});
                                      },
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 15.0)),
                      GestureDetector(
                        // When the child is tapped, show a snackbar.
                        onTap: () {
                          print("tapped");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  const Radius.circular(5.0),
                                ),
                              ),
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              child: Container(
                                  height: 150.0,
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: _interestController,
                                        decoration: new InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: hexToColor("#3A3171"),
                                                width: 1.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: hexToColor("#3A3171"),
                                                width: 1.0),
                                          ),
                                          labelText: 'Interests',
                                          labelStyle: new TextStyle(
                                              color: hexToColor("#3A3171"),
                                              fontFamily: 'opensans'),
                                          hasFloatingPlaceholder: true,
                                          alignLabelWithHint: true,
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                            new BorderRadius.circular(4.0),
                                            borderSide: new BorderSide(
                                              color: Colors.blue[700],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                  const Radius.circular(
                                                    5.0,
                                                  ),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              height: 40.0,
                                              width: 80.0,
                                              child: InkWell(
                                                child: Center(
                                                  child: Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  print("cancel");
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                },
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF3A3171),
                                                  border: Border.all(
                                                      color: Color(0xFF3A3171),
                                                      width: 1.0),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      const Radius.circular(
                                                          5.0))),
                                              margin: EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              height: 40.0,
                                              width: 80.0,
                                              child: InkWell(
                                                child: Center(
                                                  child: Text(
                                                    'ADD',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  var tempText =
                                                      _interestController.text;
                                                  _interestController.text = '';
                                                  interest.add(tempText);
                                                  print(interest.length);
                                                  print("add");
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          height: interest.isEmpty ? 60.0 : null,
                          padding: EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: hexToColor("#3A3171"), width: 1.0),
                              borderRadius:
                              BorderRadius.all(const Radius.circular(5.0))),
                          child: Wrap(
                            children: <Widget>[
                              if (interest.isEmpty)
                                Container(
                                    padding:
                                    EdgeInsets.only(top: 15.0, left: 5.0),
                                    child: Text(
                                      "Interests",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: hexToColor("#3A3171"),
                                          fontFamily: 'opensans'),
                                    ))
                              else
                                for (int i = 0; i < interest.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InputChip(
                                      label: Text(interest[i]),
                                      onDeleted: () {
                                        interest.removeAt(i);
                                        setState(() {});
                                      },
                                      materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 8.0)),
                      Row(
                        children: <Widget>[
                          //
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: new Text('Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      color: hexToColor("#3A3171"),
                                      fontFamily: 'opensans'),
                                  textAlign: TextAlign.right),
                            ),
                          )
                        ],
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 8.0)),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          if (model.isLoading) {
                            return CircularProgressIndicator();
                          } else {
                            return new Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    color: hexToColor("#3A3171"),
                                    textColor: Colors.white,
                                    elevation: 0.0,
                                    height: 52,
                                    //                                minWidth: double.infinity,
                                    //                            child: Text(_authMode == AuthMode.Login
                                    //                                ? 'LOGIN'
                                    //                                : 'SIGNUP'),
                                    onPressed: () => _submitForm(model.signup),
                                    child: new Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'opensans'),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          ;
                        },
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 55.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            //                            child: Text(
                            //                              'Text',
                            //                                textAlign: TextAlign.center,
                            //                            )

                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: 'Login now',
                                      recognizer: _recognizer1,
                                      style: TextStyle(
                                          color: hexToColor("#3A3171"),
                                          decoration:
                                          TextDecoration.underline)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0, fontFamily: 'opensans'),
                            ),

                            //                            child: new Text("Don't have an account?" ,
                            //                                style: TextStyle(fontSize: 13.0), textAlign: TextAlign.center,
                            //                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}