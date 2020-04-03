import 'package:flutter/material.dart';
import 'package:jasonw/models/journals.dart';
import 'package:jasonw/scoped_models/main.dart';
import 'package:jasonw/ui_elements/ensure.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class JournalEdit extends StatefulWidget {
  @override
  _JournalEditState createState() => _JournalEditState();
}

class _JournalEditState extends State<JournalEdit> {
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  DateTime date2;
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");
  final Map<String, dynamic> _formData = {
    'title': null,
    'descrition': null,
    'issue_date': null,
//    'image': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _issueDateFocusNode = FocusNode();
//  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Journal journal) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Title'),
        initialValue: journal == null ? '' : journal.title,
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

  Widget _buildDescriptionTextField(Journal journal) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: journal == null ? '' : journal.description,
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

  Widget _buildIssueDate(Journal journal) {
    return EnsureVisibleWhenFocused(
      focusNode: _issueDateFocusNode,
      child: DateTimePickerFormField(
//            decoration: InputDecoration(labelText: 'Date'),
        focusNode: _issueDateFocusNode,
//        initialValue: journal == null ? '' : journal.issue_date,
        decoration: new InputDecoration(
          labelText: 'Date',
          labelStyle: new TextStyle(
              color: hexToColor("#3A3171"), fontFamily: 'opensans'),
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
        ),
        inputType: InputType.date,
        format: DateFormat("yyyy-MM-dd"),
        initialDate: DateTime.now(),
        initialValue: DateTime.now(),
        editable: false,
//            decoration: InputDecoration(
//                labelText: 'Date',
//                hasFloatingPlaceholder: false
//            ),
        onChanged: (dt) {
          setState(() => date2 = dt);
          print('Selected date: $date2');
        },
        onSaved: (value) {
          _formData['issue_date'] = value.toString();
          print(value.toString());
        },
        style: new TextStyle(
            fontFamily: 'opensans',
            color: hexToColor("#3A3171"),
            fontSize: 13.0),
      ),
    );
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
                  _submitForm(model.addJournal, model.updateJournal,
                      model.selectJournal, model.selectedJournalIndex);
                },
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Journal journal) {
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
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildTitleTextField(journal),
                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildDescriptionTextField(journal),
                ),
                Container(
//                  padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                  child: _buildIssueDate(journal),
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
      Function addJournal, Function updateJournal, Function setSelectedJournal,
      [int selectedJournalIndex]) {
    print("selectedJournalIndex");
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedJournalIndex == -1) {
      addJournal(
        _formData['title'],
        _formData['description'],
        _formData['issue_date'],
//        _formData['price'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/journal_admin')
              .then((_) => setSelectedJournal(null));
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
      updateJournal(
        _formData['title'],
        _formData['description'],
        _formData['issue_date'],
//        _formData['image'],
//        _formData[' price'],
      ).then((_) {
        return Navigator.pushReplacementNamed(context, '/journal')
            .then((_) async {
          return setSelectedJournal(null);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedJournal);
        if (model.selectedJournalIndex == -1) {
          return pageContent;
        } else {
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: hexToColor("#3A3171"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              elevation: 0.0,
              title: new Text(
                'EDIT JOURNAL',
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
