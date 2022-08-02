
import 'package:qr_app/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

 Future<Database> get database async{
if(_database != null) return _database!;

_database = await initDB();

return _database!;

}

  Future<Database> initDB() async{

   Directory documentsDirectory = await getApplicationDocumentsDirectory();
   final path = join(documentsDirectory.path,'ScansDB.db');
   //print(path);

   return await openDatabase(
     path,
     version: 1,
     onOpen: (db){},
     onCreate: (Database db, int version) async{
       await db.execute('''
       CREATE TABLE Scans(
       id INTEGER PRIMARY KEY,
       type TEXT,
       value TEXT)
       ''');
     }
   );
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async{

   final db = await database;
   final res = await db.insert('Scans', nuevoScan.toJson());
   return res;
  }

  Future<ScanModel?> getScanById(int id)async{
   final db = await database;
   final res = await  db.query('Scans',where: 'id = ?',whereArgs: [id]);

   return res.isNotEmpty
       ? ScanModel.fromJson( res.first )
       : null;
  }

  Future<List<ScanModel?>> getAllScans() async {
   final db = await database;
   final res = await db.query('Scans');

   return res.isNotEmpty
       ? res.map((e) => ScanModel.fromJson(e)).toList()
       : [];
  }
  Future<List<ScanModel?>> getScansByType(String type) async{
   final db = await database;
   final res = await db.query('Scans',where: 'type = ?',whereArgs: [type]);

   return res.isNotEmpty
       ? res.map((e) => ScanModel.fromJson(e)).toList()
       : [];
  }

  Future<int> updateScans (ScanModel nuevoScan) async {
   final db = await database;
   final res = await db.update('Scans', nuevoScan.toJson(),where: 'id = ?',whereArgs: [nuevoScan.id]);
   return res;
  }
  Future<int> deleteScans(int? id) async{
   final db = await database;
   final res = await db.delete('Scans',where: 'id = ?',whereArgs: [id]);
   return res;
  }

  Future<int> deleteAllScans() async{
   final db = await database;
   final res = await db.rawDelete('''
   DELETE FROM Scans''');
   return res;
  }
}