// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   Box<String> storeData;

//   @override
//   void initState() {
//     super.initState();
//     storeData  = Hive.box<String>('friends');
//   }

//   TextEditingController _id = TextEditingController();
//   TextEditingController _name = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hive CRUD Basic"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.0),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: ValueListenableBuilder(
//                 valueListenable: storeData.listenable(),
//                 builder: (context, Box<String> friends, _) {
//                   return ListView.separated(
//                     itemBuilder: (_, index) {
//                       final key = friends.keys.toList()[index];
//                       final value = friends.get(key);
//                       return ListTile(
//                         title: Text(value),
//                         subtitle: Text(key),
//                       );
//                     },
//                     separatorBuilder: (_, index) => Divider(),
//                     itemCount: storeData.keys.toList().length,
//                   );
//                 },
//               ),
//             ),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   RaisedButton(
//                     color: Colors.teal,
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return Dialog(
//                             child: Container(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   TextField(
//                                     controller: _id,
//                                     decoration: InputDecoration(hintText: "Id"),
//                                   ),
//                                   SizedBox(height: 16),
//                                   TextField(
//                                     controller: _name,
//                                     decoration:
//                                         InputDecoration(hintText: "Name"),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       FlatButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Cancel"),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {
//                                           var key = _id.text;
//                                           var value = _name.text;
//                                           storeData.put(key, value);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Add"),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Text(
//                       "Add",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   RaisedButton(
//                     color: Colors.green,
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return Dialog(
//                             child: Container(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   TextField(
//                                     controller: _id,
//                                     decoration: InputDecoration(hintText: "Id"),
//                                   ),
//                                   SizedBox(height: 16),
//                                   TextField(
//                                     controller: _name,
//                                     decoration:
//                                         InputDecoration(hintText: "Name"),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       FlatButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Cancel"),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {
//                                           var key = _id.text;
//                                           var value = _name.text;
//                                           storeData.put(key, value);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Update"),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Text(
//                       "Update",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   RaisedButton(
//                     color: Colors.red,
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) {
//                           return Dialog(
//                             child: Container(
//                               padding: EdgeInsets.all(8),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   TextField(
//                                     controller: _id,
//                                     decoration: InputDecoration(
//                                       hintText: "Id"
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: <Widget>[
//                                       FlatButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Cancel"),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {
//                                           var key = _id.text;
//                                           storeData.delete(key);
//                                           Navigator.of(context).pop();
//                                         },
//                                         child: Text("Delete"),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                       );
//                     },
//                     child: Text(
//                       "Delete",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
