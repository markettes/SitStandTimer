import 'dart:async';

import 'package:path/path.dart';
import 'package:sitstandtimer/models/Register.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableRegister (
        ${RegisterFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${RegisterFields.date} TEXT NOT NULL,
        ${RegisterFields.sitTime} INTEGER NOT NULL,
        ${RegisterFields.standTime} INTEGER NOT NULL,
        ${RegisterFields.moveTime} INTEGER NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Register> createRegister(Register register) async {
    final db = await instance.database;

    final id = await db.insert(tableRegister, register.toMap());
    return register.copy(id: id);
  }

  Future<Register> readRegister(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRegister,
      columns: RegisterFields.values,
      where: '${RegisterFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Register.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Register>> readAllRegisters() async {
    final db = await instance.database;

    final orderBy = '${RegisterFields.date} ASC';

    final result = await db.query(tableRegister, orderBy: orderBy);

    return result.map((json) => Register.fromMap(json)).toList();
  }

  Future<int> update(Register register) async {
    final db = await instance.database;

    return db.update(
      tableRegister,
      register.toMap(),
      where: '${RegisterFields.id} = ?',
      whereArgs: [register.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableRegister,
      where: '${RegisterFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Register> readRegisterByDate(DateTime date) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRegister,
      columns: RegisterFields.values,
      where: '${RegisterFields.date} = ?',
      whereArgs: [date.toIso8601String()],
    );

    if (maps.isNotEmpty) {
      return Register.fromMap(maps.first);
    } else {
      throw Exception('Date $date not found');
    }
  }
}
