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

  List<Sintoma> lista = [];
  List<Sintoma> lista2 = [];

  List<charts.Series<Sintoma, String>> _createSampleData() {
    var date = DateTime.now();
    var date2 = DateTime(date.year, date.month, date.day);

    sintDB.listarSintoma().then((value) {
      setState(() {
        lista = value;
      });
    });

    var datas = lista.map((e) => (e.data)).toList();
    List datasAux = [];
    List datasAux3 = [];
    List datasAux4 = [];
    datas.forEach((element) {
      datasAux.add(element);
    });

    for (int i = 0; i < datasAux.length; i++) {
      var datasAux2 = DateTime.fromMillisecondsSinceEpoch(datasAux[i]);
      datasAux3.add(datasAux2);
      DateTime aux =
          DateTime(datasAux3[i].year, datasAux3[i].month, datasAux3[i].day);
      datasAux4.add(aux);
    }

    for (var j = 0; j < datasAux4.length; j++) {
      if (date2 == datasAux4[j]) {
        for (int k = 0; k < lista.length; k++) {
          lista2.add(lista[j]);
        }
      }
    }

    final data = lista2;

    return [
      charts.Series<Sintoma, String>(
          id: 'Sintomas',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Sintoma sintomas, _) => sintomas.nome,
          measureFn: (Sintoma sintomas, _) => sintomas.intensidade,
          data: data,
          labelAccessorFn: (Sintoma sintomas, _) => sintomas.nome)
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
