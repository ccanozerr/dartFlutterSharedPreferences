class Student{
  int _id;
  String _name;
  bool _isActive;

  int get id => _id;

  // ignore: unnecessary_getters_setters
  set id(int value) {
    _id = value;
  }

  String get name => _name;

  bool get isActive => _isActive;

  // ignore: unnecessary_getters_setters
  set isActive(bool value) {
    _isActive = value;
  }

  // ignore: unnecessary_getters_setters
  set name(String value) {
    _name = value;
  }

  Student(this._name, this._isActive);
  Student.withID(this._id,this._name, this._isActive);

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["id"] = _id;
    map["name"] = _name;
    map["isActive"] = _isActive;
    return map;
  }

  Student.fromMap(Map<String, dynamic> map){
    this._id  = map["id"];
    this._name = map["name"];
    this._isActive = map["isActive"] == "1" ? true : false;
  }


}