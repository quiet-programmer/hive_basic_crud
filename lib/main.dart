import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app_example/const_value.dart';
import 'package:hive_app_example/models/todo_model.dart';
import 'package:hive_app_example/src/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(TodoModelAdapter());// to register the adapter
  Hive.init(document.path);
  await Hive.openBox<TodoModel>(todoBox); // like a database table
  runApp(App());
}