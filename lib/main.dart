import 'package:flutter/material.dart';
import 'package:flutterstorageexample/file_and_directorty_operations.dart';
import 'shared_pref_usage.dart';
import 'package:flutterstorageexample/sqflite_operations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: SharedPrefUsage(),
      //home: FileAndDirectoryOperations(),
      home: SqlfLiteOperations(),
    );
  }
}