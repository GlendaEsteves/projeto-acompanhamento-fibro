import 'package:acompanhamento_fibro/botoes.dart';
import 'package:flutter/material.dart';
import './tela2.dart';
import './sintomas.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  runApp(const FibroApp());

  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'sintomas_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE sintomas(nome TEXT, intensidade INTEGER, data INTEGER)',
      );
    },
    version: 1,
  );

  Future<void> inserirSintoma(Sintoma sintoma) async {
    final db = await database;
    await db.insert(
      'sintoma',
      sintoma.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Sintoma>> sintoma() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sintomas');

    return List.generate(maps.length, (i) {
      return Sintoma(
          nome: maps[i]['nome'],
          intensidade: maps[i]['intensidade'],
          data: maps[i]['data']);
    });
  }

  await inserirSintoma(resultado);
}

class FibroApp extends StatelessWidget {
  const FibroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fibromialgia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Acompanhamento de Sintomas da Fibromialgia'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  var resultado;

  List<String> nomeSintoma = [
    'Dores no corpo',
    'Sensibilidade na Pele',
    'Distúrbios do sono',
    'Falta de concentração',
    'Alterações gastrointestinais',
    'Outro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        centerTitle: true,
        title: Text(
          'Acompanhamento de Sintomas da Fibromialgia',
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'O que você sentiu hoje?',
                style: TextStyle(fontSize: 20),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ...nomeSintoma
                      .asMap()
                      .entries
                      .map((t) => BotoesSintomas(t.value, () async {
                            resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tela2(
                                        sintomas: t.value,
                                      )),
                            );
                            if (t.value == 'Outro') {}
                            print(t.value);
                          }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
