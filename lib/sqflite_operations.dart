import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterstorageexample/models/student.dart';
import 'package:flutterstorageexample/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SqlfLiteOperations extends StatefulWidget {
  @override
  _SqlfLiteOperationsState createState() => _SqlfLiteOperationsState();
}

class _SqlfLiteOperationsState extends State<SqlfLiteOperations> {
  DatabaseHelper databaseHelper;
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";
  int id = 0;
  int clickedListID = 0;
  bool isActive = false;
  List<Student> allStudents;
  var _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allStudents = List<Student>();
    databaseHelper = DatabaseHelper();
    databaseHelper.allStudents().then((mapList){
      for(Map map in mapList){
        allStudents.add(Student.fromMap(map));
      }
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("SqfLite Usage"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "Enter Student Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (input) {
                        if (input.length < 3) {
                          return "Please enter more than  3 letter";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (input) {
                        name = input;
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text(
                      "Active",
                    ),
                    value: isActive,
                    onChanged: (switchValue) {
                      setState(() {
                        isActive = switchValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Save"),
                  color: Colors.blueAccent.shade200,
                  onPressed: () {
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      _addStudent(Student(name,isActive));
                    }
                  },
                ),
                RaisedButton(
                  child: Text("Update"),
                  color: Colors.yellow.shade200,
                  onPressed: () {
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      _updateStudent(Student.withID(id, name, isActive), clickedListID);
                    }
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text("Delete"),
                  onPressed: (){
                    _deleteAllStudentsFromTable();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allStudents.length,
                itemBuilder: (context, index){
                  return Card(
                    color: allStudents[index].isActive == true ? Colors.green : Colors.red,
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          name = allStudents[index].name;
                          isActive = allStudents[index].isActive;
                          id = allStudents[index].id;
                          clickedListID = index;
                          _controller.text = name;
                        });
                      },
                      title: Text(allStudents[index].name),
                      subtitle: Text(allStudents[index].id.toString()),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: (){
                          databaseHelper.deleteStudent(allStudents[index].id).then((deletedID){
                            setState(() {
                              allStudents.removeAt(index);
                            });
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addStudent(Student student) async{
    await databaseHelper.addStudent(student).then((index){
      setState(() {
        student.id = index;
        allStudents.insert(0, student);
      });
    });
  }

  void _deleteAllStudentsFromTable() async{
    await databaseHelper.deleteAllStudents().then((deletedRows){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(deletedRows.toString() + " rows deleted."),
          duration: Duration(seconds: 1),
        ),
      );
    });
    setState(() {
      allStudents.clear();
    });
  }

  void _updateStudent(Student student, int clickedListID) async{
    await databaseHelper.updateStudent(student).then((index){
      setState(() {
        allStudents[index] = student;
      });
    });
  }
}
