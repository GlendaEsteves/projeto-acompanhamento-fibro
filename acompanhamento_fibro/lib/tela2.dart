import 'package:acompanhamento_fibro/sintomas.dart';

import './main.dart';
import 'package:flutter/material.dart';

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
          title: const Text('Escolha a intensidade do seu sintoma',
              style: TextStyle(fontSize: 18)),
          backgroundColor: Colors.blueAccent),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Slider(
                max: 10.0,
                divisions: 10,
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
                            title: 'Acompanhamento de Sintomas da Fibromialgia',
                          )));
                  var data = DateTime.now().millisecondsSinceEpoch;
                  var valorSliderEscolhido = valorSlider;
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
