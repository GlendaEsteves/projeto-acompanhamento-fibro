import 'dart:collection';

import 'package:acompanhamento_fibro/botoes.dart';
import 'package:acompanhamento_fibro/database_manager.dart';
import 'package:acompanhamento_fibro/tela_grafico.dart';
import 'package:flutter/material.dart';
import 'sintomas.dart';
import 'tela_intensidade_sintomas.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FibroApp());
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final sintDB = SintomasDB.instance;

  var _resultado;

  List<String> nomeSintoma = [
    'Dores no corpo',
    'Sensibilidade na Pele',
    'Distúrbios do sono',
    'Falta de concentração',
    'Alterações gastrointestinais',
    'Outro'
  ];

  late List<Sintoma> lista;

  List<charts.Series<Sintoma, String>> _createSampleData() {
    var date = DateTime.now();

    sintDB.listarSintoma().then((value) {
      setState(() {
        lista = value;
        print(lista);
      });
    });

    print(lista.map((e) => (e.data)));

    final data = lista;

    return [
      charts.Series<Sintoma, String>(
        id: 'Sintomas',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Sintoma sintomas, _) => sintomas.nome,
        measureFn: (Sintoma sintomas, _) => sintomas.intensidade,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        centerTitle: true,
        title: const Text(
          'Acompanhamento de Sintomas da Fibromialgia',
          style: TextStyle(fontSize: 15),
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
                            _resultado = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tela2(
                                        sintomas: t.value,
                                      )),
                            );
                            await sintDB.inserirSintomas(_resultado);
                            print(await sintDB.listarSintoma());
                          }))
                ],
              ),
              FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TelaGrafico(_createSampleData())),
                    );
                  },
                  child: const Icon(Icons.addchart_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
