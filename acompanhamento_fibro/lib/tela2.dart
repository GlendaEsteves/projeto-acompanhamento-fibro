import 'package:acompanhamento_fibro/sintomas.dart';
import 'package:flutter/material.dart';

class Tela2 extends StatefulWidget {
  String sintomas;
  Tela2({Key? key, required this.sintomas}) : super(key: key);
  @override
  _Tela2State createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  double valorSlider = 0;
  @override
  Widget build(BuildContext context) {
    var sintomas = widget.sintomas;
    return Scaffold(
      appBar: AppBar(
          title: Text('Descreva a Intensidade do Sintoma:\n$sintomas',
              style: TextStyle(fontSize: 16)),
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
                  var data = DateTime.now().millisecondsSinceEpoch;
                  var valorSliderEscolhido = valorSlider;

                  var sintomaInstancia = Sintoma(
                      nome: sintomas,
                      intensidade: valorSliderEscolhido,
                      data: data);
                  Navigator.pop(context, sintomaInstancia);
                },
                child: const Icon(Icons.add),
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
