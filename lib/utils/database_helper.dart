import 'package:flutterstorageexample/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  //Column names
  String _studentTable = "student";
  String _columnID = "id";
  String _columnName = "name";
  String _columnIsActive = "isActive";

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if (_databaseHelper == null){
      print("DatabaseHelper is null, will be create.");
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    }else{
      print("DatabaseHelper is not null.");
      return _databaseHelper;
    }
  }

  Future<Database> _getDatabase() async{
    if(_database == null){
      print("Database is null, will be create.");
      _database = await _initializeDatabase();
      return _database;
    }else{
      print("Database is not null.");
      return _database;
    }
  }

  _initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "student.db");
    print("Db full path is: $path" );
    var studentDB = await openDatabase(path,version: 1,onCreate: _createDB);
    return studentDB;
  }

  Future _createDB(Database db, int version) async{
    print("DB is creating.");
    //await db.execute("DROP TABLE $_studentTable");
    await db.execute("CREATE TABLE $_studentTable ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnName TEXT, $_columnIsActive TEXT )");
  }

  Future<int> addStudent(Student student) async{
    //_database.rawQuery("we can write whole sql query like this");
    var db = await _getDatabase();
    var result = db.insert(_studentTable, student.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> allStudents() async{
    var db = await _getDatabase();
    var result = db.query(_studentTable, orderBy: '$_columnID DESC');
    return result;
  }
  
  Future<int> updateStudent(Student student) async{
    var db = await _getDatabase();
    var result = db.update(_studentTable, student.toMap(), where: '$_columnID = ?',whereArgs: [student.id]);
    return result;
  }
  
  Future<int> deleteStudent(int id) async{
    var db = await _getDatabase();
    var result = db.delete(_studentTable, where: '$_columnID = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllStudents() async{
    var db = await _getDatabase();
    var result = db.delete(_studentTable);
    return result;
  }

}