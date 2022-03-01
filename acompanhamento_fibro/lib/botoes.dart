import 'package:flutter/material.dart';

class BotoesSintomas extends StatelessWidget {
  final String texto;
  final void Function() quandoSelecionado;

  BotoesSintomas(this.texto, this.quandoSelecionado);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (quandoSelecionado),
        child: Text(texto),
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 7, 82, 143),
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            textStyle: const TextStyle(color: Colors.white)));
  }
}
