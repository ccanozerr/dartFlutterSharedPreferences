import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUsage extends StatefulWidget {
  @override
  _SharedPrefUsageState createState() => _SharedPrefUsageState();
}

class _SharedPrefUsageState extends State<SharedPrefUsage> {
  String name;
  int id;
  bool isActive;
  var formKey = GlobalKey<FormState>();
  var mySharedPreferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
        .then((sharedPref) => mySharedPreferences = sharedPref);
  }

  @override
  void dispose() {
    mySharedPreferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences Usage"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                      labelText: "Enter your name please",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (value) {
                    id = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter your id please",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioListTile(
                  value: true,
                  groupValue: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = true;
                    });
                  },
                  title: Text("Active"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioListTile(
                  value: false,
                  groupValue: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = false;
                    });
                  },
                  title: Text("Not Active"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _add,
                    child: Text(
                      "Save",
                    ),
                    color: Colors.lightBlue,
                  ),
                  RaisedButton(
                    onPressed: _show,
                    child: Text(
                      "Show",
                    ),
                    color: Colors.lightBlue,
                  ),
                  RaisedButton(
                    onPressed: _delete,
                    child: Text(
                      "Delete",
                    ),
                    color: Colors.lightBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _add() async{
    formKey.currentState.save();
    await (mySharedPreferences as SharedPreferences).setString("name", name);
    await (mySharedPreferences as SharedPreferences).setInt("id", id);
    await (mySharedPreferences as SharedPreferences).setBool("isActive", isActive);
  }

  void _show() {
    debugPrint("Name is: " + (mySharedPreferences as SharedPreferences).getString("name") ?? "Name value not found");
    debugPrint("ID is: " + (mySharedPreferences as SharedPreferences).getInt("id").toString() ?? "ID value not found");
    debugPrint("Is Active : " + (mySharedPreferences as SharedPreferences).getBool("isActive").toString() ?? "Is active value not found");
  }

  void _delete() {
    (mySharedPreferences as SharedPreferences).remove("name");
    (mySharedPreferences as SharedPreferences).remove("id");
    (mySharedPreferences as SharedPreferences).remove("isActive");
  }
}
