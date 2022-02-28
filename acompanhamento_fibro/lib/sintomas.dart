class Sintoma {
  String nome = "";
  double intensidade = 0;
  int data = 0;

  Sintoma({required this.nome, required this.intensidade, required this.data});

  Map<String, dynamic> toMap() {
    return {'nome': nome, 'intensidade': intensidade, 'data': data};
  }

  String toString() {
    return 'Sintoma{nome: $nome, intensidade: $intensidade, data: $data}';
  }
}
