import 'package:flutter/material.dart';
import 'package:jasonw/models/reflects.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:jasonw/ui_elements/ensure.dart';

import 'package:scoped_model/scoped_model.dart';

class ReflectGoalsEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReflectGoalsEditPageState();
  }
}

class ReflectGoalsEditPageState extends State<ReflectGoalsEditPage> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  final Map<String, dynamic> _formData = {
    'title': null,
    'descrition': null,
//    'price': null,
//    'image': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
//  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Reflect reflect) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Title'),
        initialValue: reflect == null ? '' : reflect.title,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 5) {
            return 'Title is required and should be 5+ characters long.';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Reflect reflect) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: reflect == null ? '' : reflect.description,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required and should be 10+ characters long.';
          }
        },
        onSaved: (String value) {
          _formData['description'] = value;
          print(value);
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Goal Date'),
        initialValue: null == null ? '' : '',
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be valid number';
          }
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
        });
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                color: hexToColor('#3A3171'),
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: () {
                  print("${model.selectedReflectIndex}");
                  _submitForm(model.addReflect, model.updateReflect,
                      model.selectReflect, model.selectedReflectIndex);
                },
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Reflect reflect) {
//    final double deviceWidth = MediaQuery.of(context).size.width;
//    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;
//    final double targetPadding = deviceWidth - targetWidth;
    return Tab(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
//          height: 300,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
//          margin: EdgeInsets.only(),
//          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
//              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
//                _buildTitleTextField(reflect),

//                _buildDescriptionTextField(reflect),

//                Container(
//                  height: 50.0,
//                  color: hexToColor("#3A3171"),
//                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildTitleTextField(reflect),
                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildDescriptionTextField(reflect),
                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
//                  child: _buildPriceTextField(),
                    ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildSubmitButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(
      Function addReflect, Function updateReflect, Function setSelectedReflect,
      [int selectedReflectIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedReflectIndex == -1) {
      print("ref");
      addReflect(
        _formData['title'],
        _formData['description'],
//        _formData['image'],
//        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/reflect')
              .then((_) => setSelectedReflect(null));
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
    } else {
      updateReflect(
        _formData['title'],
        _formData['description'],
//        _formData['image'],
//        _formData[' price'],
      ).then((_) {
        return Navigator.pushReplacementNamed(context, '/reflect')
            .then((_) => setSelectedReflect(null));
      });
    }

//    if (!_formKey.currentState.validate()) {
//      return;
//    }
//    _formKey.currentState.save();
//    if (selectedReflectIndex == null) {
//      addReflect(
//        _formData['title'],
//        _formData['description'],
////        _formData['image'],
////        _formData['price'],
//      );
//    }
//    else {
//      updateReflect(
//        _formData['title'],
//        _formData['description'],
////        _formData['image'],
////        _formData['price'],
//      );
//    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedReflect);
        if (model.selectedReflectIndex == -1) {
          return pageContent;
        } else {
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: hexToColor("#3A3171"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0.0,
              title: new Text(
                'EDIT REFLECT',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'opensans',
                    fontSize: 16.0),
              ),
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.home),
                    // icon: new Image.asset('images/JASON-LOGO-FINAL-4.png'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    }),
              ],
            ),
            body: Stack(
              children: <Widget>[SizedBox(height: 300, child: pageContent)],
            ),
          );
        }
      },
    );
  }
}
