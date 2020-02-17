import 'package:flutter/material.dart';
import 'package:jasonw/scoped_models/main.dart';

import 'package:scoped_model/scoped_model.dart';


class NewsList extends StatefulWidget {

  final MainModel model;

  NewsList(this.model);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  initState(){
    print('nhi chala lol');
    widget.model.fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allNews[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
//                  model.selectProduct(model.allProducts[index].id);
//                  model.deleteProduct();
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
//                      NetworkImage(model.allNews[index].image),
//                    ),
                    title: Text(model.allNews[index].title),
//                    subtitle:
//                    Text('\$${model.allNews[index].price.toString()}'),
//                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allNews.length,
        );
      },
    );
  }

}
