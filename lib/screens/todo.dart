import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_app_example/const_value.dart';
import 'package:hive_app_example/models/todo_model.dart';

enum TodoFilter { ALL, COMPLETED, INCOMPLETED }

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoFilter filter = TodoFilter.ALL;
  Box<TodoModel> storedata;

  bool _isCom = false;

  TextEditingController _title = TextEditingController();
  TextEditingController _details = TextEditingController();

  bool checkCom() {
    return _isCom = !_isCom;
  }

  @override
  void initState() {
    super.initState();
    storedata = Hive.box<TodoModel>(todoBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Todo"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value.compareTo("All") == 0) {
                setState(() {
                  filter = TodoFilter.ALL;
                });
              } else if (value.compareTo("Compeleted") == 0) {
                setState(() {
                  filter = TodoFilter.COMPLETED;
                });
              } else {
                setState(() {
                  filter = TodoFilter.INCOMPLETED;
                });
              }
            },
            itemBuilder: (_) {
              return ["All", "Compeleted", "Incompleted"].map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ValueListenableBuilder(
            valueListenable: storedata.listenable(),
            builder: (context, Box<TodoModel> todos, _) {
              List<int> keys;

              if (filter == TodoFilter.ALL) {
                keys = todos.keys
                    .cast<int>()
                    .toList(); // returns all the keys that exist in the box
              } else if (filter == TodoFilter.COMPLETED) {
                keys = todos.keys
                    .cast<int>()
                    .where((key) => todos.get(key).isCompleted)
                    .toList();
              } else {
                keys = todos.keys
                    .cast<int>()
                    .where((key) => !todos.get(key).isCompleted)
                    .toList();
              }

              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final int key = keys[index];
                  final TodoModel todo = todos.get(key);
                  return ListTile(
                    leading: Icon(
                      Icons.done,
                      color:
                          todo.isCompleted == true ? Colors.green : Colors.red,
                    ),
                    title: Text(todo.title),
                    subtitle: Text(todo.detail),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Are you sure?"),
                                content: Text("You are about to delete a task"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      storedata.delete(key);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yes"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No"),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    onTap: () {
                      //to make task complete or incomplete
                      TodoModel nTodo = TodoModel(
                        title: todo.title,
                        detail: todo.detail,
                        isCompleted: checkCom(),
                      );
                      storedata.put(key, nTodo);
                    },
                  );
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: keys.length,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _details,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              final String title = _title.text;
                              final String details = _details.text;

                              TodoModel todo = TodoModel(
                                  title: title,
                                  detail: details,
                                  isCompleted: false);
                              storedata.add(todo);
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text("Cancel"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
