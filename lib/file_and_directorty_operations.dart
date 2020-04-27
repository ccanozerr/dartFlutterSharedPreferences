import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileAndDirectoryOperations extends StatefulWidget {
  @override
  _FileAndDirectoryOperationsState createState() =>
      _FileAndDirectoryOperationsState();
}

class _FileAndDirectoryOperationsState
    extends State<FileAndDirectoryOperations> {
  var textController = TextEditingController();

  Future<String> get getDirectory async {
    Directory directory = await getApplicationDocumentsDirectory();
    debugPrint("Directory path: " + directory.path);
    return directory.path;
  }

  Future<File> get createFile async {
    var createdFilePath = await getDirectory;
    return File(createdFilePath + "/myFile.txt");
  }

  Future<String> readFile() async {
    try {
      var myFile = await createFile;
      String fileContent = await myFile.readAsString();
      return fileContent;
    } catch (e) {
      return "An error occurred $e";
    }
  }

  Future<File> writeFile(String string) async {
    var myFile = await createFile;
    return myFile.writeAsString(string);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File and Directory Operations"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "This area will be saved on file.",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: _writeFile,
                  color: Colors.lightBlue,
                  child: Text("Write to file."),
                ),
                RaisedButton(
                  onPressed: _readFile,
                  color: Colors.lightBlue,
                  child: Text("Read from file."),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _writeFile() {
    writeFile(textController.text.toString());
  }

  void _readFile() async{
    //debugPrint(await readFile());
    readFile().then((content){
      debugPrint(content);
    });
  }
}
