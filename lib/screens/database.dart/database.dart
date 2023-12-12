import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_/screens/database.dart/model.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath(); // Corrected method name
    return openDatabase(join(path, 'mydb.db'),
        onCreate: (database, version) async {
          await database.execute("""CREATE TABLE MYTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT NOT NULL,
        Date TEXT NOT NULL,
        Description TEXT NOT NULL
      ) """);
        },
        version: 2, // Increase the version number
        onUpgrade: (db, oldVersion, newVersion) async {
          // Add any necessary updates to the schema here
        });
  }

  Future<bool> insertDB(DataModel dataModel) async {
    final Database db = await initDB();
    db.insert("MYTable", dataModel.toMap()).then((value) => print('sucess'));
    return true;
  }

  Future<List<DataModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> datas = await db.query("MYTable");
    return datas.map((e) => DataModel.fromMap(e)).toList();
  }

  Future<void> updateData(DataModel dataModel, int id) async {
    final Database db = await initDB();
    await db
        .update('MYTable', dataModel.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteData(int id) async {
    final Database db = await initDB();
    await db.delete("MYTable", where: "id=?", whereArgs: [id]);
  }

  Future<void> close() async {
    final Database db = await initDB();
    db.close();
  }
}
