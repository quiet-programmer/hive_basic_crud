import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_app_example/src/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("friends"); // like a database table
  runApp(App());
}