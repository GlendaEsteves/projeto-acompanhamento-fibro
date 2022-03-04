import 'dart:io';
import 'package:acompanhamento_fibro/sintomas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SintomasDB {
  static final SintomasDB _instance = SintomasDB.internal();

  factory SintomasDB() => _instance;
  static Database? _db;

  Future<Database> get db async => _db ?? await _initDb();

  SintomasDB.internal();

  SintomasDB._privateConstructor();
  static final SintomasDB instance = SintomasDB._privateConstructor();

  _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'sintomasDB');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Sintomas (
            nome TEXT NOT NULL,
            intensidade REAL,
            data INTEGER NOT NULL
          )
          ''');
  }

  Future<void> inserirSintomas(Sintoma sintoma) async {
    final db = await instance.db;
    await db.insert('Sintomas', sintoma.toMap());
    ConflictAlgorithm.replace;
  }

  Future<List<Sintoma>> listarSintoma() async {
    final Database db = await instance.db;
    final List<Map<String, dynamic>> maps = await db.query('Sintomas');
    return List.generate(maps.length, (i) {
      return Sintoma(
          nome: maps[i]['nome'],
          intensidade: maps[i]['intensidade'],
          data: maps[i]['data']);
    });
  }
}
