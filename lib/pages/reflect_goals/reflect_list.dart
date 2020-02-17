// import 'package:flutter/material.dart';
// import 'package:jasonw/scoped_models/main.dart';
// import 'package:scoped_model/scoped_model.dart';
// import '../reflect_goals/reflect_edit.dart';

// class ReflectGoalsListPage extends StatefulWidget {

//   final MainModel model;

//   ReflectGoalsListPage(this.model);


//   @override
//   _ReflectGoalsListPageState createState() => _ReflectGoalsListPageState();
// }

// class _ReflectGoalsListPageState extends State<ReflectGoalsListPage> {
//   @override

//   initState() {
//     widget.model.fetchReflects();
//     super.initState();
//   }

//   Widget _buildEditButton(BuildContext context, int index, MainModel model) {
//     return IconButton(
//       icon: Icon(Icons.edit),
//       onPressed: () {
//         model.selectReflect(model.allReflects[index].reflectID);
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return ReflectGoalsEditPage();
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//       builder: (BuildContext context, Widget child, MainModel model) {
//         return ListView.builder(
//           itemBuilder: (BuildContext context, int index) {
//             return Dismissible(
//               key: Key(model.allReflects[index].title),
//               onDismissed: (DismissDirection direction) {
//                 if (direction == DismissDirection.endToStart) {
//                   model.selectReflect(model.allReflects[index].reflectID);
//                   model.deleteReflect();
//                 } else if (direction == DismissDirection.startToEnd) {
//                   print('Swiped start to end');
//                 } else {
//                   print('Other swiping');
//                 }
//               },
//               background: Container(color: Colors.red),
//               child: Column(
//                 children: <Widget>[
//                   ListTile(
// //                    leading: CircleAvatar(
// //                      backgroundImage:
// //                      NetworkImage(model.allReflects[index].image),
// //                    ),
//                     title: Text(model.allReflects[index].title),
//                     subtitle:
//                     Text(model.allReflects[index].description),
//                     trailing: _buildEditButton(context, index, model),
//                   ),
//                   Divider()
//                 ],
//               ),
//             );
//           },
//           itemCount: model.allReflects.length,
//         );
//       },
//     );
//   }
// }


