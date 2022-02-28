import 'package:flutter/material.dart';

void main() {
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
      home:
          const MyHomePage(title: 'Acompanhamento de Sintomas da Fibromialgia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _addSintomas = 0;
  double valorSlider = 0;

  void _() {
    setState(() {
      _addSintomas++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        centerTitle: true,
        title: Text(
          widget.title,
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
                'Quais sintomas você sentiu hoje?',
                style: TextStyle(fontSize: 20),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Dores no Corpo')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Sensibilidade na Pele')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Distúrbios do sono')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Falta de concentração')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Alterações gastrointestinais')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Tela2()));
                      },
                      child: Text('Outro'))
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  @override
  _Tela2State createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  double valorSlider = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Escolha a intensidade do seu sintoma'),
          backgroundColor: Colors.blueAccent),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Slider(
                max: 10.0,
                divisions: 5,
                value: valorSlider,
                label: valorSlider.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    valorSlider = value;
                  });
                },
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: 'Teste',
                          )));
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(height: 50),
      ),
    );
  }
}
