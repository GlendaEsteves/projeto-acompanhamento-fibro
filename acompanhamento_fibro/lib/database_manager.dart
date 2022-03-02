import "dart:io" as io;
import 'package:acompanhamento_fibro/sintomas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SintomasDB {
  static final SintomasDB _instance = SintomasDB.internal();

  factory SintomasDB() => _instance;
  static Database? _db;

  Future<Database> get db async => _db ?? await initDb();

  SintomasDB.internal();

  SintomasDB._privateConstructor();
  static final SintomasDB instance = SintomasDB._privateConstructor();

  Future<Database> initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "sintomasDB.db");
    var sintDb = await openDatabase(path, version: 1);
    return sintDb;
  }

  Future criarTabela() async {
    var dbSintomas = await SintomasDB().db;
    var res = await dbSintomas.execute(
      'CREATE TABLE IF NOT EXISTS Sintomas(nome TEXT, intensidade REAL, data INTEGER)',
    );
    return res;
  }

  Future<void> inserirSintomas(Sintoma sintoma) async {
    final db = _db;
    await db?.insert(
      'Sintomas',
      sintoma.toMap(),
    );
    ConflictAlgorithm.replace;
  }

  Future listarSintomas() async {
    var dbClient = await SintomasDB().db;
    final res = await dbClient.rawQuery("SELECT * FROM Sintomas");
    return res;
  }
}
