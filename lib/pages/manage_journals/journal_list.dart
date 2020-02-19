import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';

import 'package:scoped_model/scoped_model.dart';
import '../manage_journals/journal_edit.dart';

class JournalList extends StatefulWidget {

  final MainModel model;
  JournalList(this.model);

  @override
  _JournalListState createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {

  @override
  void initState() {
    // TODO: implement initState
    widget.model.fetchJournalALL();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectJournal(model.alljournalall[index].journalID);
        print(model.alljournalall[index].journalID);
        print('hi');
//        Navigator.pushReplacementNamed(context, '/journal_edit');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return JournalEdit();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.alljournalall[index].journalID),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectJournal(model.alljournalall[index].journalID);
                  model.deleteJournal();
                } else if (direction == DismissDirection.startToEnd) {
                  print('Swiped start to end');
                } else {
                  print('Other swiping');
                }
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
//                    leading: CircleAvatar(
//                      backgroundImage:
//                      NetworkImage(model.allReflects[index].image),
//                    ),
                    title: Text(model.alljournalall[index].title),
                    subtitle:
                    Text(model.alljournalall[index].description),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.alljournalall.length,
        );
      },
    );
  }
}
