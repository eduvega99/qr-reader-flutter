import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_reader/models/scan_models.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      }
    );
  }


  Future<int> insertScan(ScanModel newScan) async {
    final db = await database;
    final response = await db.insert('Scans', newScan.toJson());
    
    return response;
  }

  // Otra forma de hacerlo
  // newScanRaw(ScanModel newScan) async {
    
  //   final id    = newScan.id;
  //   final type  = newScan.type;
  //   final value = newScan.value;
    
  //   final db = await database;
    
  //   final response = await db.rawInsert('''
  //     INSERT INTO Scans(id, type, value)
  //     VALUES ($id, '$type', '$value')
  //   ''');

  //   return response;
  // }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final response = await db.query('Scans', where: 'id= ?', whereArgs: [id]);
    
    return response.isNotEmpty ? ScanModel.fromJson(response[0]) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final response = await db.query('Scans');

    if(response.isEmpty) return [];
    
    final scanList = response.map((record) => ScanModel.fromJson(record)).toList();
    return scanList;
  }

  Future<List<ScanModel>> getScansByType(type) async {
    final db = await database;
    final response = await db.query('Scans', where: 'type= ?', whereArgs: [type]);

    if(response.isEmpty) return [];
    
    final scanList = response.map((record) => ScanModel.fromJson(record)).toList();
    return scanList;
  }

  // Otra forma de obtener por tipos
  // Future<List<ScanModel>> getScansByType(type) async {
  //   final db = await database;
  //   final response = await db.rawQuery('''
  //     SELECT * FROM Scans WHERE type = '$type'
  //   ''');

  //   if(response.isEmpty) return [];
    
  //   final scanList = response.map((record) => ScanModel.fromJson(record)).toList();
  //   return scanList;
  // }

  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final response = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
    return response;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final response = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final response = await db.delete('Scans');
    return response;
  }
  
}